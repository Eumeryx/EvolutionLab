// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_window_close/flutter_window_close.dart';

import '../life/state.dart';
import '../bridge/bridge.dart';
import '../bridge/bridge_extension.dart';

Future<T?> showAlertDialog<T>(
  BuildContext context, {
  Widget? content,
  Widget? title,
  List<Widget>? actions,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(title: title, content: content, actions: actions),
  );
}

// 重设网格形状的弹窗
class ResetShapeDialog extends StatelessWidget {
  final LifeState life;
  // 目标形状
  final Shape targetShape;
  // 如果为真，必需大于目标形状
  final bool moreTarget;
  // 清除现有细胞
  final bool? clean;

  ResetShapeDialog(
    this.life, {
    required this.targetShape,
    this.moreTarget = false,
    this.clean,
    super.key,
  }) {
    widthCtrl.text = targetShape.x.toString();
    heightCtrl.text = targetShape.y.toString();
  }

  final TextEditingController widthCtrl = TextEditingController();
  final TextEditingController heightCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var clean = this.clean;
    bool fullScreen = true;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(flex: 2, child: Text('大小', textAlign: TextAlign.start)),
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: widthCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (fullScreen) {
                      final num = int.tryParse(value) ?? 0;
                      heightCtrl.text = (num ~/ size.aspectRatio).toString();
                    }
                  },
                ),
              ),
              const Expanded(child: Text('x', textAlign: TextAlign.center)),
              Expanded(
                child: TextField(
                  controller: heightCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (fullScreen) {
                      final num = int.tryParse(value) ?? 0;
                      widthCtrl.text = (num * size.aspectRatio).toInt().toString();
                    }
                  },
                ),
              ),
            ],
          ),
          StatefulBuilder(
            builder: (context, setState) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (clean != null) const Text('清除细胞'),
                if (clean != null)
                  Switch(value: clean!, onChanged: (i) => setState(() => clean = i)),
                const Text('占满屏幕'),
                Switch(value: fullScreen, onChanged: (i) => setState(() => fullScreen = i)),
              ],
            ),
          ),
          TextButton(
            child: const Text('确认'),
            onPressed: () async {
              final x = int.tryParse(widthCtrl.text) ?? 0;
              final y = int.tryParse(heightCtrl.text) ?? 0;
              final shape = Shape(x: 0 != x ? x : 1, y: 0 != y ? y : 1);

              if (moreTarget && targetShape > shape) {
                await showAlertDialog(
                  context,
                  content: SelectableText('网格必需大于 ${targetShape.x}x${targetShape.y}!'),
                );
              } else {
                await life.setShape(shape, clean: clean);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}

// 弹框显示 pattern 信息并设置到网格，成功返回 true
Future<bool?> showPatternInfo(
  BuildContext context,
  LifeState life,
  Pattern pattern, {
  bool? clean,
  bool? center,
  void Function(Pattern pattern)? successCallback,
}) {
  final shape = pattern.header.shape;
  var moreShape = shape > life.shape;

  return showAlertDialog(
    context,
    title: const Text('RLE 信息'),
    content: StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          pattern.header.toWidget(context: context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (clean != null) const Text('清除网格'),
              if (clean != null) Switch(value: clean!, onChanged: (i) => setState(() => clean = i)),
              if (center != null) const Text('居中'),
              if (center != null)
                Switch(value: center!, onChanged: (i) => setState(() => center = i)),
            ],
          ),
          TextButton(
            child: Text(moreShape ? '尺寸过大，点此扩大网格' : '确认'),
            onPressed: () async {
              if (moreShape) {
                await showAlertDialog(
                  context,
                  title: const Text('调整网格大小'),
                  content: ResetShapeDialog(life, targetShape: shape, moreTarget: true),
                );
                return setState(() => moreShape = shape > life.shape);
              }

              var cells = pattern.cells;

              if (center == true) {
                final offset = shape.getCenterOffset(life.shape);
                cells = cells.applyOffset(offset);
              }

              if (successCallback != null) {
                successCallback(pattern);
              } else {
                await life.setCells(cells, clean: clean);
              }

              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    ),
  );
}

// 从文件打开一个 RLE 文件，成功返回 true
Future<bool?> openRleFile(BuildContext context, LifeState life) async {
  const title = '请选择一个 RLE 文件';
  FilePickerResult? filePicker;

  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    filePicker = await FilePicker.platform.pickFiles(
      dialogTitle: title,
      type: FileType.custom,
      allowedExtensions: ['rle'],
    );
  } else {
    // 移动端不支持 rle 扩展名
    filePicker = await FilePicker.platform.pickFiles(dialogTitle: title, type: FileType.any);
  }

  final path = filePicker?.files.single.path;
  if (path == null) return false;

  try {
    final pattern = await File(path).readAsString().then((str) => bridge.decodeRle(rle: str));

    return showPatternInfo(context, life, pattern, clean: false, center: true);
  } catch (e) {
    showAlertDialog(
      context,
      title: const Text('打开文件失败！'),
      content: Text(e.toString()),
    );

    return false;
  }
}

class SaveDialog extends StatelessWidget {
  const SaveDialog({required this.life, required this.child, super.key});

  final Widget child;
  final LifeState life;

  @override
  Widget build(BuildContext context) {
    Future<bool> showSaveDialog() async {
      return await showAlertDialog(
        context,
        title: const Text('保存当前状态?'),
        actions: [
          ElevatedButton(
            child: const Text('保存并退出'),
            onPressed: () async {
              await life.saveState();
              return Navigator.of(context).pop(true);
            },
          ),
          ElevatedButton(
            child: const Text('直接退出'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    }

    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      FlutterWindowClose.setWindowShouldCloseHandler(showSaveDialog);

      return child;
    } else {
      return WillPopScope(
        onWillPop: showSaveDialog,
        child: child,
      );
    }
  }
}

/*
* 绘制滑块的同时绘制当前数值，无需滑动才显示。
* See https://github.com/flutter/flutter/issues/34704
*/
class ThumbShape extends RoundSliderThumbShape {
  final _indicatorShape = const PaddleSliderValueIndicatorShape();

  const ThumbShape();

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    super.paint(
      context,
      center,
      activationAnimation: activationAnimation,
      enableAnimation: enableAnimation,
      sliderTheme: sliderTheme,
      value: value,
      textScaleFactor: textScaleFactor,
      sizeWithOverflow: sizeWithOverflow,
      isDiscrete: isDiscrete,
      labelPainter: labelPainter,
      parentBox: parentBox,
      textDirection: textDirection,
    );

    _indicatorShape.paint(
      context,
      center,
      activationAnimation: const AlwaysStoppedAnimation(1),
      enableAnimation: enableAnimation,
      labelPainter: labelPainter,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      value: value,
      textScaleFactor: 0.7,
      sizeWithOverflow: sizeWithOverflow,
      isDiscrete: isDiscrete,
      textDirection: textDirection,
    );
  }
}
