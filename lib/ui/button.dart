import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

import '../life/state.dart';
import '../life/editor_renderer.dart';

class ControllerButton extends StatefulWidget {
  const ControllerButton(this.life, this.lifeEditorController, {super.key});

  final LifeState life;
  final LifeEditorController lifeEditorController;

  @override
  State<ControllerButton> createState() => _ControllerButtonState();
}

class _ControllerButtonState extends State<ControllerButton> {
  LifeState get life => widget.life;
  LifeEditorController get editor => widget.lifeEditorController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (life.isPaused && !editor.inEditing) ...subButtonList,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: editor.inEditing ? editorButtonList() : mainButtonList,
        ),
      ],
    );
  }

  late List<Widget> mainButtonList = [
    _SpeedSlider(life: life),
    FloatingActionButton.small(
      child: Icon(life.isPaused ? Icons.play_arrow : Icons.pause),
      onPressed: () => setState(() => life.isPaused ? life.resume() : life.pause()),
    ),
  ];

  late List<Widget> subButtonList = [
    FloatingActionButton.small(
      tooltip: '菜单',
      child: const Icon(Icons.more_vert),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    ),
    FloatingActionButton.small(
      tooltip: '编辑',
      child: const Icon(Icons.edit),
      onPressed: () => setState(() => editor.open()),
    ),
    _RandSlider(life),
    FloatingActionButton.small(
      tooltip: '单步演化',
      onPressed: life.next,
      child: const Icon(Icons.skip_next),
    ),
  ];

  List<Widget> editorButtonList() => [
        if (editor.insertPattern == null)
          FloatingActionButton.small(
            tooltip: '插入',
            child: const Icon(Icons.add),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        FloatingActionButton.small(
          tooltip: '完成',
          child: const Icon(Icons.check),
          onPressed: () async {
            if (editor.insertPattern != null) {
              editor.applyInsertPattern(life.cells);
            } else {
              await life.cleanCells();
              await life.setCells(life.cells.value);
              setState(() => editor.close());
            }
          },
        ),
        FloatingActionButton.small(
          tooltip: '放弃',
          child: const Icon(Icons.close),
          onPressed: () async {
            if (editor.insertPattern != null) {
              editor.insertPattern = null;
            } else {
              life.cells.value = await life.getCells();
              setState(() => editor.close());
            }
          },
        ),
      ];

  @override
  void initState() {
    super.initState();
    editor.insertPatternNotifier.addListener(() => setState(() {}));
  }
}

class _SpeedSlider extends StatefulWidget {
  const _SpeedSlider({required this.life});

  final LifeState life;

  @override
  State<_SpeedSlider> createState() => _SpeedSliderState();
}

class _SpeedSliderState extends State<_SpeedSlider> {
  LifeState get life => widget.life;

  int curr = 3;
  final delayed = [0.25, 0.5, 0.8, 1, 1.5, 2, 4];

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      tooltip: '调节速度',
      child: const Icon(Icons.fast_forward),
      onPressed: () => showPopupWindow(
        context,
        bgColor: Colors.transparent,
        gravity: KumiPopupGravity.centerTop,
        duration: const Duration(milliseconds: 16),
        targetRenderBox: context.findRenderObject()! as RenderBox,
        childFun: (_) => RotatedBox(
          key: GlobalKey(),
          quarterTurns: 3,
          child: StatefulBuilder(
            builder: (_, setState) => Slider(
              max: 6,
              divisions: 6,
              value: curr.toDouble(),
              label: '${delayed[curr]}x',
              onChanged: (value) => setState(() {
                curr = value.toInt();
                life.setDelayed(100 ~/ delayed[curr]);
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _RandSlider extends StatefulWidget {
  const _RandSlider(this.life);

  final LifeState life;

  @override
  State<_RandSlider> createState() => _RandSliderState();
}

class _RandSliderState extends State<_RandSlider> {
  LifeState get life => widget.life;

  double distr = 0.5;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      tooltip: '随机生命',
      child: const Icon(Icons.shuffle),
      onPressed: () => showPopupWindow(
        context,
        bgColor: Colors.transparent,
        gravity: KumiPopupGravity.leftCenter,
        duration: const Duration(milliseconds: 16),
        targetRenderBox: context.findRenderObject()! as RenderBox,
        childFun: (_) => StatefulBuilder(
          key: GlobalKey(),
          builder: (_, setState) => Slider(
            min: 0,
            max: 1,
            value: distr,
            label: '存活率 ${distr.toStringAsFixed(2)}',
            onChanged: (value) => setState(() => distr = value),
            onChangeEnd: ((value) async => await life.rand(value)),
          ),
        ),
      ),
    );
  }
}
