import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bridge/bridge.dart';
import '../assets/pattern.dart';
import '../bridge/bridge_extension.dart';

typedef ShapeNotifier = ValueNotifier<Shape>;
typedef CellsNotifier = ValueNotifier<List<Position>>;

class Status {
  int step = 0;
  int count = 0;
}

class LifeState {
  LifeState() {
    _init();
  }

  late Life _life;
  late PatternAssets patternAssets;
  late SharedPreferences _sharedPreferences;

  Boundary _boundary = Boundary.None;
  Boundary get boundary => _boundary;

  final cellsNotifier = CellsNotifier([]);
  List<Position> get cells => cellsNotifier.value;
  set cells(List<Position> value) => cellsNotifier.value = value;

  final shapeNotifier = ShapeNotifier(Shape(x: 100, y: 50));
  Shape get shape => shapeNotifier.value;
  set shape(Shape value) => shapeNotifier.value = value;

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    final boundary = _sharedPreferences.getString('boundary');
    _boundary = _boundary.fromName(boundary);

    Pattern pattern;
    try {
      final prevPattern = _sharedPreferences.getString('prev_pattern');
      _sharedPreferences.remove('prev_pattern');

      pattern = await bridge.decodeRle(rle: prevPattern!);
      shape = pattern.header.shape;
    } catch (_) {
      pattern = await bridge.defaultPattern();
    }

    cells = pattern.cells;
    _life = await bridge.create(shape: shape, boundary: _boundary);
    await _life.setCells(cells: pattern.cells);

    patternAssets = await rootBundle
        .loadStructuredData('assets/pattern/index.json', (json) async => jsonDecode(json))
        .then((json) => PatternAssets.fromJson(json));
  }

  Future<bool> saveState() async {
    return _sharedPreferences.setString(
      'prev_pattern',
      await bridge.encodeRle(
        pattern: Pattern(header: Header(shape: shape), cells: cells),
      ),
    );
  }

  /*
  * 控制生命演化的方法
  */
  var isPaused = true;
  var _delayed = const Duration(milliseconds: 100);
  late final _controller = _createEvolveStream().listen(null);

  Stream<void> _createEvolveStream() async* {
    while (true) {
      yield await Future.wait([next(), Future.delayed(_delayed)]);
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
  Future<List<Position>> getCells() => _life.getCells();

  Future<void> next() async {
    await _life.evolve();
    cells = await _life.getCells();
  }

  Future<void> rand(double distr) async {
    await _life.rand(distr: distr);
    cells = await _life.getCells();
  }

  Future<void> setShape(Shape value, {bool? clean}) async {
    await _life.setShape(shape: value, clean: clean);

    shape = value;
    cells = clean == true ? [] : await _life.getCells();
  }

  Future<void> setCells(List<Position> value, {bool? clean}) async {
    if (clean == true) await _life.cleanCells();
    await _life.setCells(cells: value);
    cells = await _life.getCells();
  }

  Future<void> cleanCells() => _life.cleanCells();

  Future<void> setBoundary(Boundary boundary) async {
    await _life.setBoundary(boundary: boundary);
    _boundary = boundary;

    await _sharedPreferences.setString('boundary', _boundary.name);
  }

  void dispose() {
    _controller.cancel();
    _life.field0.dispose();
  }
}
