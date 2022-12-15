import 'package:evolution_lab/life/renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:evolution_lab/bridge/bridge.dart';

void main() {
  // 横屏，去状态栏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(const MaterialApp(home: EvolutionLab()));
}

class EvolutionLab extends StatefulWidget {
  const EvolutionLab({super.key});

  @override
  State<EvolutionLab> createState() => _EvolutionLabState();
}

class _EvolutionLabState extends State<EvolutionLab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LifeRenderer(),
    );
  }
}
