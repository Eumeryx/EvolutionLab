import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './utils.dart';
import '../life/state.dart';
import '../bridge/bridge.dart';
import '../bridge//bridge_extension.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer(this.life, {super.key});

  final LifeState life;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          child: const Text('新建或扩展网格'),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => ResetShapeDialog(
              life,
              title: '新建或扩展网格',
              targetShape: life.shape.value,
            ),
          ),
        ),
        MaterialButton(
          child: const Text('打开 RLE 文件'),
          onPressed: () async {
            final pattern = await openRleFile(context, life);

            if (pattern != null) {
              await life.setCells(pattern.cells);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}
