import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './life/state.dart';
import './life/renderer.dart';

void main() async {
  // 横屏，去状态栏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  final life = LifeState();
  await life.initState();

  runApp(MaterialApp(home: EvolutionLab(life)));
}

class EvolutionLab extends StatefulWidget {
  const EvolutionLab(this.life, {super.key});

  final LifeState life;

  @override
  State<EvolutionLab> createState() => _EvolutionLabState();
}

class _EvolutionLabState extends State<EvolutionLab> {
  LifeState get life => widget.life;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LifeRenderer(life.shape, life.cells),
      ),
    );
  }
}
