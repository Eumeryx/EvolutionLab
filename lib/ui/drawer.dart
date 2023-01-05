import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './utils.dart';
import '../life/state.dart';
import '../life/editor_renderer.dart';
import '../bridge/bridge.dart';
import '../bridge/bridge_extension.dart';
import '../assets/pattern.dart';
import '../assets/pattern_icons.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer(this.life, this.lifeEditorController, {super.key});

  final LifeState life;
  final LifeEditorController lifeEditorController;

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  LifeState get life => widget.life;
  LifeEditorController get editor => widget.lifeEditorController;

  late String item = editor.inEditing ? 'stillLife' : 'setting';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: itemMap[item]!),
        ButtonBar(children: [
          IconButton(
            tooltip: '静物',
            icon: const Icon(PatternIcons.box, size: 16),
            onPressed: item == 'stillLife' ? null : () => setState(() => item = 'stillLife'),
          ),
          IconButton(
            tooltip: '振荡器',
            onPressed: item == 'oscillator' ? null : () => setState(() => item = 'oscillator'),
            icon: const Icon(PatternIcons.blinker, size: 18),
          ),
          IconButton(
            tooltip: '飞船',
            icon: const Icon(PatternIcons.glider, size: 18),
            onPressed: item == 'spaceship' ? null : () => setState(() => item = 'spaceship'),
          ),
          IconButton(
            tooltip: '收藏',
            icon: const Icon(Icons.star),
            onPressed: item == 'collect' ? null : () => setState(() => item = 'collect'),
          ),
          IconButton(
            tooltip: '设置',
            icon: const Icon(Icons.settings),
            onPressed: item == 'setting' ? null : () => setState(() => item = 'setting'),
          ),
        ]),
      ],
    );
  }

  late Map<String, Widget> itemMap = {
    'setting': _Setting(life),
    'collect': PatternListView(life.patternAssets.collect, life, editor),
    'stillLife': PatternListView(life.patternAssets.stillLife, life, editor),
    'oscillator': PatternListView(life.patternAssets.oscillator, life, editor),
    'spaceship': PatternListView(life.patternAssets.spaceship, life, editor),
  };
}

class PatternListView extends StatelessWidget {
  const PatternListView(this.patternList, this.life, this.editor, {super.key});

  final LifeState life;
  final LifeEditorController editor;
  final PatternList patternList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: patternList.length,
      separatorBuilder: (_, i) => const Divider(),
      itemBuilder: (context, index) => FutureBuilder(
        future: patternList.get(index),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          } else {
            final pattern = snapshot.data!;
            final inEditor = editor.inEditing;

            return Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: pattern.header.toWidget(),
                onTap: () {
                  showPatternInfo(
                    context,
                    life,
                    pattern,
                    clean: inEditor ? null : true,
                    center: inEditor ? null : true,
                    successCallback: inEditor ? (_) => editor.insertPattern = pattern : null,
                  );

                  if (inEditor) Scaffold.of(context).closeEndDrawer();
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class _Setting extends StatelessWidget {
  const _Setting(this.life);

  final LifeState life;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MaterialButton(
        child: const Text('新建或扩展网格'),
        onPressed: () => showAlertDialog(
          context,
          title: const Text('新建或扩展网格'),
          content: ResetShapeDialog(life, clean: true, targetShape: life.shape),
        ),
      ),
      MaterialButton(
        child: const Text('打开 RLE 文件'),
        onPressed: () async {
          if (true == await openRleFile(context, life)) {
            Navigator.pop(context);
          }
        },
      ),
      SetBoundary(life),
      MaterialButton(
        child: const Text('LifeWiki'),
        onPressed: () => launchUrl(Uri.parse('https://conwaylife.com/wiki/Main_Page')),
      ),
    ]);
  }
}

class SetBoundary extends StatelessWidget {
  SetBoundary(this.life, {super.key});

  final LifeState life;

  final items = [Boundary.Sphere.name, Boundary.Mirror.name, Boundary.None.name]
      .map((n) => DropdownMenuItem(value: n, child: Text(n)))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Text('边界条件:', textAlign: TextAlign.center, textScaleFactor: 1.1)),
      Expanded(
        child: StatefulBuilder(
          builder: (context, setState) => DropdownButtonHideUnderline(
            child: DropdownButton(
              items: items,
              isExpanded: true,
              value: life.boundary.name,
              onChanged: (String? value) async {
                await life.setBoundary(life.boundary.fromName(value));
                setState(() {});
              },
            ),
          ),
        ),
      ),
    ]);
  }
}
