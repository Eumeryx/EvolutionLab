import 'package:evolution_lab/life/state.dart';
import 'package:flutter/material.dart';

import './renderer.dart';
import '../bridge/bridge.dart';
import '../bridge/bridge_extension.dart';

class LifeEditorAndRenderer extends StatefulWidget {
  const LifeEditorAndRenderer(
    this.life, {
    required this.lifeEditorController,
    super.key,
  });

  final LifeState life;
  final LifeEditorController lifeEditorController;

  @override
  State<LifeEditorAndRenderer> createState() => _LifeEditorAndRendererState();
}

class _LifeEditorAndRendererState extends State<LifeEditorAndRenderer> {
  ValueNotifier<Shape> get shapeNotifier => widget.life.shape;
  ValueNotifier<List<Position>> get cellsNotifier => widget.life.cells;
  LifeEditorController get lifeEditorController => widget.lifeEditorController;

  double cellWidth = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ValueListenableBuilder(
      valueListenable: shapeNotifier,
      builder: (context, shape, _) {
        cellWidth = shape.getCellWidth(screenSize);

        return InteractiveViewer(
          maxScale: shape.y.toDouble(),
          child: Center(
            child: GestureDetector(
              onTapUp: _onTapUpCallback,
              child: LifeRenderer(cellWidth, shape & cellWidth, cellsNotifier),
            ),
          ),
        );
      },
    );
  }

  void _onTapUpCallback(TapUpDetails details) {
    if (lifeEditorController.canSingleCellFlip) {
      final offset = details.localPosition;
      final position = Position(x: offset.dx ~/ cellWidth, y: offset.dy ~/ cellWidth);
      cellsNotifier.value.singleCellFlip(position);
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      cellsNotifier.notifyListeners();
    }
  }
}

class LifeEditorController {
  bool canSingleCellFlip = false;
}
