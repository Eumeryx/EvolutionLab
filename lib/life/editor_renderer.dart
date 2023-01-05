// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';

import './state.dart';
import './renderer.dart';
import '../bridge/bridge.dart';
import '../bridge/bridge_extension.dart';

class LifeEditorController {
  bool inEditing = false;
  bool canSingleCellFlip = false;

  final insertPatternNotifier = ValueNotifier<Pattern?>(null);
  Pattern? get insertPattern => insertPatternNotifier.value;
  set insertPattern(Pattern? pattern) {
    canSingleCellFlip = pattern == null ? true : false;
    insertPatternNotifier.value = pattern;
  }

  Position? _insertPosition;

  void applyInsertPattern(ValueNotifier<List<Position>> cellsNotifier) {
    cellsNotifier.value.insertPattern(insertPattern!, _insertPosition);
    cellsNotifier.notifyListeners();

    _insertPosition = null;
    insertPattern = null;
  }

  void open() => canSingleCellFlip = inEditing = true;

  void close() => canSingleCellFlip = inEditing = false;
}

class LifeEditorAndRenderer extends StatefulWidget {
  const LifeEditorAndRenderer(
    this.life, {
    required this.controller,
    super.key,
  });

  final LifeState life;
  final LifeEditorController controller;

  @override
  State<LifeEditorAndRenderer> createState() => _LifeEditorAndRendererState();
}

class _LifeEditorAndRendererState extends State<LifeEditorAndRenderer> {
  ValueNotifier<Shape> get shapeNotifier => widget.life.shape;
  ValueNotifier<List<Position>> get cellsNotifier => widget.life.cells;

  @override
  void initState() {
    super.initState();
    Listenable.merge([
      shapeNotifier,
      widget.controller.insertPatternNotifier,
    ]).addListener(() => setState(() {}));
  }

  double cellWidth = 0;
  Rect gridRect = Rect.zero;
  Rect screenRect = Rect.zero;
  final _scaleController = TransformationController();

  Shape get gridShape => shapeNotifier.value;
  Pattern? get insertPattern => widget.controller.insertPattern;

  @override
  Widget build(BuildContext context) {
    screenRect = Offset.zero & MediaQuery.of(context).size;
    cellWidth = gridShape.getCellWidth(screenRect.size);

    final size = gridShape & cellWidth;
    gridRect = screenRect.center - size.center(Offset.zero) & size;

    return InteractiveViewer(
      maxScale: gridShape.y.toDouble(),
      transformationController: _scaleController,
      child: Stack(children: [
        GestureDetector(
          onTapUp: _onTapUpCallback,
          child: Center(child: LifeRenderer(cellWidth, size, cellsNotifier)),
        ),
        if (insertPattern != null) _createInsertPattern(insertPattern!),
      ]),
    );
  }

  void _onTapUpCallback(TapUpDetails details) {
    if (widget.controller.canSingleCellFlip) {
      final offset = details.localPosition - gridRect.topLeft;
      final position = Position(x: offset.dx ~/ cellWidth, y: offset.dy ~/ cellWidth);

      cellsNotifier.value.singleCellFlip(position);
      cellsNotifier.notifyListeners();
    }
  }

  Widget _createInsertPattern(Pattern pattern) {
    final size = pattern.header.shape & cellWidth;
    final offset = _scaleController.toScene(screenRect.center) - size.center(Offset.zero);

    var rect = _adjustInsertRect(offset & size);

    return StatefulBuilder(
      builder: (context, setState) => Positioned(
        top: rect.top,
        left: rect.left,
        child: GestureDetector(
          onPanUpdate: (details) => setState(() => rect = rect.shift(details.delta)),
          onPanEnd: (details) => setState(() => rect = _adjustInsertRect(rect)),
          child: LifeRenderer(
            cellWidth,
            size,
            ValueNotifier(pattern.cells),
            gridColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  Rect _adjustInsertRect(Rect rect) {
    final shape = insertPattern!.header.shape;

    // 对齐网格
    final offset = rect.topLeft - gridRect.topLeft;
    var position = Position(x: offset.dx ~/ cellWidth, y: offset.dy ~/ cellWidth);

    // 确保插入的模式在网格内部
    if (position.x < 0) position.x = 0;
    if (position.y < 0) position.y = 0;

    var delta = gridShape.x - position.x - shape.x;
    if (delta < 0) position.x += delta;

    delta = gridShape.y - position.y - shape.y;
    if (delta < 0) position.y += delta;

    widget.controller._insertPosition = position;

    return position.toOffset(cellWidth) + gridRect.topLeft & rect.size;
  }
}
