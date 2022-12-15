import 'package:flutter/material.dart';

import './bridge.dart';

extension ImplShape on Shape {
  Size getCanvasSize(Size screenSize) {
    final width = screenSize.width / x;
    final height = screenSize.height / y;
    final cellWidth = height < width ? height : width;

    return Size(x * cellWidth, y * cellWidth);
  }
}

extension ImplPosition on Position {
  Rect toRect(double width) => Rect.fromLTWH(x * width, y * width, width, width);
}
