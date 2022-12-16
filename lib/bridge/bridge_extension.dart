import 'package:flutter/material.dart';

import './bridge.dart';

extension ImplShape on Shape {
  Size getCanvasSize(Size screenSize) {
    final width = screenSize.width / x;
    final height = screenSize.height / y;
    final cellWidth = height < width ? height : width;

    return Size(x * cellWidth, y * cellWidth);
  }

  bool include(Shape shape) => x > shape.x && y > shape.y;
}

extension ImplPosition on Position {
  Rect toRect(double width) => Rect.fromLTWH(x * width, y * width, width, width);
}

extension ImplHeader on Header {
  Widget toWidget({BuildContext? context}) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: $name'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Owner: $owner'),
              context != null && comment != null
                  ? TextButton(
                      child: const Text('more'),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('更多信息'),
                          content: SelectableText(comment!),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Size: ${x}x$y'), Text('Rule: $rule')],
          ),
        ],
      );
}
