import 'package:flutter/services.dart';

import '../bridge/bridge.dart';

class PatternAssets {
  final PatternList collect;
  final PatternList stillLife;
  final PatternList oscillator;
  final PatternList spaceship;

  PatternAssets.fromJson(Map<String, dynamic> json)
      : collect = PatternList(json['collect']),
        stillLife = PatternList(json['stillLife']),
        oscillator = PatternList(json['oscillator']),
        spaceship = PatternList(json['spaceship']);
}

class PatternList {
  final int length;
  final List<String> _paths;
  final List<Pattern> _patternCache = [];

  PatternList(List paths)
      : _paths = List<String>.from(paths),
        length = paths.length;

  Future<Pattern> get(int index) async {
    if (index < _patternCache.length) return _patternCache[index];

    final pattern = await rootBundle.loadStructuredData(
      'assets/pattern/${_paths[index]}',
      (rle) => bridge.decodeRle(rle: rle),
    );

    _patternCache.add(pattern);
    return pattern;
  }
}
