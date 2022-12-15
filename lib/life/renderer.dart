import 'package:flutter/material.dart';

class LifeRenderer extends StatelessWidget {
  const LifeRenderer({super.key});

  @override
  Widget build(BuildContext context) {
    final gridShape = [50, 25];
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width / gridShape[0];
    final height = screenSize.height / gridShape[1];
    final cellWidth = height < width ? height : width;

    final canvasSize = Size(gridShape[0] * cellWidth, gridShape[1] * cellWidth);

    return CustomPaint(
      size: canvasSize,
      painter: _CellPainter(cellWidth),
      foregroundPainter: _GridPainter(gridShape),
    );
  }
}

class _CellPainter extends CustomPainter {
  final double width;

  _CellPainter(this.width);

  final cellPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var rect = Rect.fromLTWH(45 * width, 20 * width, width, width);

    path.addRect(rect);
    canvas.drawPath(path, cellPaint);
  }

  @override
  bool shouldRepaint(_) => true;
}

class _GridPainter extends CustomPainter {
  final List<int> gridShape;

  _GridPainter(this.gridShape);

  final gridPaint = Paint()
    ..isAntiAlias
    ..color = const Color.fromARGB(255, 180, 195, 210)
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.height / gridShape[1];

    for (int x = 0; x <= gridShape[0]; x++) {
      canvas.drawLine(Offset(x * width, 0), Offset(x * width, size.height), gridPaint);
    }

    for (var i = 0; i <= gridShape[1]; i++) {
      canvas.drawLine(Offset(0, i * width), Offset(size.width, i * width), gridPaint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
