import 'package:flutter/material.dart';

import '../bridge/bridge.dart';
import '../assets/pattern.dart';

class LifeState {
  late Life _life;

  final cells = ValueNotifier<List<Position>>([]);
  final shape = ValueNotifier<Shape>(Shape(x: 100, y: 50));
  late PatternCollectList patternCollectList;

  Boundary _boundary = Boundary.None;
  Boundary get boundary => _boundary;

  Future<void> initState() async {
    patternCollectList = PatternCollectList();
    patternCollectList.init();

    final defaultPattern = await bridge.defaultPattern();
    cells.value = defaultPattern.cells;

    _life = await bridge.create(shape: shape.value, boundary: _boundary);
    await _life.setCells(cells: defaultPattern.cells);
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

  /*
  * 重新包装的 Rust 端 API
  */
  void next() async {
    await _life.evolve();
    cells.value = await _life.getCells();
  }

  Future<void> rand(double distr) async {
    await _life.rand(distr: distr);
    cells.value = await _life.getCells();
  }

  Future<void> setShape(Shape newShape, {bool? clean}) async {
    await _life.setShape(shape: newShape, clean: clean);

    if (clean == true) {
      cells.value = [];
    } else {
      cells.value = await _life.getCells();
    }

    shape.value = newShape;
  }

  Future<void> setCells(List<Position> newCells) async {
    await _life.setCells(cells: newCells);
    cells.value = await _life.getCells();
  }

  Future<void> cleanCells() => _life.cleanCells();

  Future<void> setBoundary(Boundary boundary) async {
    _life.setBoundary(boundary: boundary);
    _boundary = boundary;
  }

  void dispose() {
    _controller.cancel();
    _life.field0.dispose();
  }
}
