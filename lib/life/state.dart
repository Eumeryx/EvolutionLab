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
  }

  /*
  * 控制生命演化的方法
  */
  var isPaused = true;
  var _delayed = const Duration(milliseconds: 100);
  late final _controller = _createEvolveStream().listen(null);

  Stream<void> _createEvolveStream() async* {
    while (true) {
      await Future.wait([_life.evolve(), Future.delayed(_delayed)]);
      cells.value = await _life.getCells();

      yield null;
    }
  }

  void pause() {
    if (!isPaused) {
      _controller.pause();
      isPaused = _controller.isPaused;
    }
  }

  void resume() {
    _controller.resume();
    isPaused = _controller.isPaused;
  }

  void setDelayed(int milliseconds) {
    _delayed = Duration(milliseconds: milliseconds);
  }

  void next() async {
    await _life.evolve();
    cells.value = await _life.getCells();
  }

  Future<void> rand(double distr) async {
    await _life.rand(distr: distr);
    cells.value = await _life.getCells();
  }

  void dispose() {
    _controller.cancel();
    _life.field0.dispose();
  }
}
