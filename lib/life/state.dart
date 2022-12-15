import 'package:flutter/material.dart';

import '../bridge/bridge.dart';

class LifeState {
  late Life _life;

  final cells = ValueNotifier<List<Position>>([]);
  final shape = ValueNotifier<Shape>(Shape(x: 50, y: 25));

  Boundary _boundary = Boundary.None;
  Boundary get boundary => _boundary;

  Future<void> initState() async {
    final defaultCells = await bridge.defaultCells();
    cells.value = defaultCells;

    _life = await bridge.create(shape: shape.value, boundary: _boundary);
    await _life.setCells(cells: defaultCells);

    _controller.resume();
  }

  var delayed = const Duration(milliseconds: 100);
  late final _controller = _createEvolveStream().listen(null);

  Stream<void> _createEvolveStream() async* {
    while (true) {
      final results = await Future.wait([_life.evolve(), Future.delayed(delayed)]);
      cells.value = results.first;

      yield null;
    }
  }
}
