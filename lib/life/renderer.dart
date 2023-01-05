import 'package:flutter/material.dart';

import '../bridge/bridge.dart';
import '../bridge/bridge_extension.dart';

class LifeRenderer extends StatelessWidget {
  const LifeRenderer(
    this.cellWidth,
    this.size,
    this.cellsNotifier, {
    this.cellColor = Colors.black,
    this.gridColor = const Color.fromARGB(255, 210, 210, 210),
    super.key,
  });

  final Size size;
  final double cellWidth;
  final ValueNotifier<List<Position>> cellsNotifier;
  final Color cellColor;
  final Color gridColor;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: size,
        painter: _CellPainter(cellsNotifier, cellWidth, cellColor),
        child: RepaintBoundary(
          child: CustomPaint(size: size, painter: _GridPainter(cellWidth, gridColor)),
        ),
      ),
    );
  }
}

class _CellPainter extends CustomPainter {
  final Color cellColor;
  final double cellWidth;
  final ValueNotifier<List<Position>> cellsNotifier;

  _CellPainter(this.cellsNotifier, this.cellWidth, this.cellColor) : super(repaint: cellsNotifier);

  final cellPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    for (final c in cellsNotifier.value) {
      path.addRect(c.toRect(cellWidth));
    }

    canvas.drawPath(path, cellPaint..color = cellColor);
  }

  @override
  bool shouldRepaint(_) => true;
}

class _GridPainter extends CustomPainter {
  final Color gridColor;
  final double cellWidth;

  _GridPainter(this.cellWidth, this.gridColor);

  final gridPaint = Paint()
    ..isAntiAlias
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    for (int x = 0; x <= size.width ~/ cellWidth; x++) {
      path.moveTo(x * cellWidth, 0);
      path.lineTo(x * cellWidth, size.height);
    }

    for (int y = 0; y <= size.height ~/ cellWidth; y++) {
      path.moveTo(0, y * cellWidth);
      path.lineTo(size.width, y * cellWidth);
    }

    canvas.drawPath(path, gridPaint..color = gridColor);
  }

  @override
  bool shouldRepaint(_) => true;
}
