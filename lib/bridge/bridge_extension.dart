import 'package:flutter/material.dart';

import './bridge.dart';

extension ImplShape on Shape {
  double getCellWidth(Size screenSize) {
    final width = screenSize.width / x;
    final height = screenSize.height / y;
    return height < width ? height : width;
  }

  Size operator &(double cellWidth) => Size(x * cellWidth, y * cellWidth);

  bool include(Shape shape) => x >= shape.x && y >= shape.y;

  Position getCenterOffset(Shape targetShape) =>
      Position(x: (targetShape.x - x) ~/ 2, y: (targetShape.y - y) ~/ 2);
}

extension ImplPosition on Position {
  Offset toOffset(double width) => Offset(x * width, y * width);

  Rect toRect(double width) => Rect.fromLTWH(x * width, y * width, width, width);

  Position operator +(Position offset) => Position(x: x + offset.x, y: y + offset.y);

  bool operator <(Position rhs) => y < rhs.y || (y == rhs.y && x < rhs.x);

  bool operator >(Position rhs) => y > rhs.y || (y == rhs.y && x > rhs.x);

  bool eq(Position rhs) => y == rhs.y && x == rhs.x;

  bool operator <=(Position rhs) => this < rhs || eq(rhs);

  bool operator >=(Position rhs) => this > rhs || eq(rhs);
}

extension ImplListPosition on List<Position> {
  List<Position> applyOffset(Position offset) => map((ori) => ori + offset).toList();

  void singleCellFlip(Position position) {
    if (isEmpty) {
      add(position);
    } else if (position < first || last < position) {
      insert(position < first ? 0 : length, position);
    } else {
      int min = 0;
      int max = length;

      while (min < max) {
        final int mid = min + ((max - min) >> 1);
        final curr = this[mid];

        if (curr < position) {
          min = mid + 1;
        } else if (curr > position) {
          max = mid;
        } else {
          removeAt(mid);
          return;
        }
      }

      insert(min, position);
    }
  }

  void insertPattern(Pattern pattern, [Position? offset]) {
    var cells = offset == null ? pattern.cells : pattern.cells.applyOffset(offset);

    if (cells.last <= first || last <= cells.first) {
      insertAll(
        cells.last <= first ? 0 : length,
        cells.sublist(
          cells.first.eq(last) ? 1 : 0,
          cells.last.eq(first) ? cells.length - 1 : cells.length,
        ),
      );
    } else {
      var start = 0;
      for (final curr in cells) {
        if (start != -1) start = indexWhere((e) => e >= curr, start);

        if (start == -1) {
          add(curr);
        } else {
          if (curr < this[start]) insert(start, curr);
          start++;
        }
      }
    }
  }
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
            children: [Text('Size: ${shape.x}x${shape.y}'), Text('Rule: $rule')],
          ),
        ],
      );
}

extension ImplBoundary on Boundary {
  Boundary fromName(String? name) =>
      {
        Boundary.None.name: Boundary.None,
        Boundary.Sphere.name: Boundary.Sphere,
        Boundary.Mirror.name: Boundary.Mirror,
      }[name] ??
      this;
}
