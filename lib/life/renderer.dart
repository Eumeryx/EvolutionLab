import 'package:flutter/material.dart';

import '../bridge/bridge.dart';
import '../bridge/bridge_extension.dart';

class LifeRenderer extends StatelessWidget {
  const LifeRenderer(this.cellWidth, this.size, this.cellsNotifier, {super.key});

  final Size size;
  final double cellWidth;
  final ValueNotifier<List<Position>> cellsNotifier;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: size,
        painter: _CellPainter(cellsNotifier, cellWidth),
        child: RepaintBoundary(
          child: CustomPaint(size: size, painter: _GridPainter(cellWidth)),
        ),
      ),
    );
  }
}

class _CellPainter extends CustomPainter {
  final double cellWidth;
  final ValueNotifier<List<Position>> cellsNotifier;

  _CellPainter(this.cellsNotifier, this.cellWidth) : super(repaint: cellsNotifier);

  final cellPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    for (final c in cellsNotifier.value) {
      path.addRect(c.toRect(cellWidth));
    }

    canvas.drawPath(path, cellPaint);
  }

  @override
  bool shouldRepaint(_) => true;
}

class _GridPainter extends CustomPainter {
  final double cellWidth;

  _GridPainter(this.cellWidth);

  final gridPaint = Paint()
    ..isAntiAlias
    ..color = const Color.fromARGB(255, 210, 210, 210)
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    for (int x = 0; x <= size.width ~/ cellWidth; x++) {
      canvas.drawLine(Offset(x * cellWidth, 0), Offset(x * cellWidth, size.height), gridPaint);
    }

    for (int y = 0; y <= size.height ~/ cellWidth; y++) {
      canvas.drawLine(Offset(0, y * cellWidth), Offset(size.width, y * cellWidth), gridPaint);
    }
  }

  @override
  bool shouldRepaint(_) => true;
}
