import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knitting/view/knitting_pattern_list/components/setting_dialog.dart';

class KnittingPatternListScreen extends HookWidget {
  const KnittingPatternListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final border = Border.all(
      color: Colors.white70,
      width: 2,
    );

    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: border,
              ),
              child: IconButton(
                color: Colors.grey,
                iconSize: 100,
                icon: const Icon(CupertinoIcons.add),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return const SettingDialog();
                  },
                ),
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.primaries[index % 6],
              border: border,
            ),
          );
        },
      ),
    );
  }
}
