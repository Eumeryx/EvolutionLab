import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './life/state.dart';
import './life/editor_renderer.dart';
import './ui/button.dart';
import './ui/utils.dart';
import './ui/drawer.dart';

void main() {
  // 横屏，去状态栏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(MaterialApp(
    home: EvolutionLab(life: LifeState()),
    theme: ThemeData(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: Colors.blue.withAlpha(150),
      ),
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.never,
        thumbShape: ThumbShape(),
      ),
    ),
  ));
}

class EvolutionLab extends StatefulWidget {
  const EvolutionLab({required this.life, super.key});

  final LifeState life;

  @override
  State<EvolutionLab> createState() => _EvolutionLabState();
}

class _EvolutionLabState extends State<EvolutionLab> with WidgetsBindingObserver {
  LifeState get life => widget.life;

  final lifeEditorController = LifeEditorController();

  @override
  Widget build(BuildContext context) {
    return SaveDialog(
      life: life,
      child: Scaffold(
        drawerEdgeDragWidth: 0,
        endDrawer: Drawer(child: EndDrawer(life, lifeEditorController)),
        body: LifeEditorAndRenderer(life, controller: lifeEditorController),
        floatingActionButton: ControllerButton(life, lifeEditorController),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    life.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        life.pause(); // 后台时暂停
        break;
      case AppLifecycleState.resumed:
        setState(() {});
        break;
      default:
        break;
    }
  }
}
