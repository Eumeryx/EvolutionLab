// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../life/state.dart';
import '../bridge/bridge.dart';
import '../bridge/bridge_extension.dart';

// 重设网格形状的弹窗
class ResetShapeDialog extends StatefulWidget {
  const ResetShapeDialog(
    this.life, {
    required this.targetShape,
    this.clean = true,
    this.title = '新建',
    this.moreTarget = false,
    super.key,
  });

  // 清除现有细胞
  final bool clean;
  // 弹窗标题
  final String title;
  final LifeState life;
  // 目标形状
  final Shape targetShape;
  // 如果为真，必需大于目标形状
  final bool moreTarget;

  @override
  State<ResetShapeDialog> createState() => _ResetShapeDialogState();
}

class _ResetShapeDialogState extends State<ResetShapeDialog> {
  String get title => widget.title;
  LifeState get life => widget.life;
  bool get moreTarget => widget.moreTarget;
  Shape get targetShape => widget.targetShape;

  bool fullScreen = true;
  late bool cleanCell = widget.clean;
  late Size size = MediaQuery.of(context).size;
  late TextEditingController widthCtrl = TextEditingController(text: targetShape.x.toString());
  late TextEditingController heightCtrl = TextEditingController(text: targetShape.y.toString());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
                  onChanged: (v) {
                    if (fullScreen) {
                      final width = int.tryParse(v) ?? 0;
                      final height = size.height ~/ (size.width / width);
                      heightCtrl.text = height.toString();
                    }
                  },
                ),
              ),
              const Expanded(child: Text('x', textAlign: TextAlign.center)),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: heightCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (v) {
                    if (fullScreen) {
                      final height = int.tryParse(v) ?? 0;
                      final width = size.width ~/ (size.height / height);
                      widthCtrl.text = width.toString();
                    }
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('清除细胞'),
              Switch(
                value: cleanCell,
                onChanged: (i) => setState(() => cleanCell = i),
              ),
              const Text('占满屏幕'),
              Switch(
                value: fullScreen,
                onChanged: (i) => setState(() => fullScreen = i),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
            child: const Text('确认'),
            onPressed: () async {
              final shape = Shape(x: int.parse(widthCtrl.text), y: int.parse(heightCtrl.text));

              if (moreTarget && !shape.include(targetShape)) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: SelectableText('网格必需大于 ${targetShape.x}x${targetShape.y}!'),
                  ),
                );
              } else {
                await life.setShape(shape, clean: cleanCell);
                Navigator.pop(context);
              }
            })
      ],
    );
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
