import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_viewer.dart';

class KnittingPatternScreen extends HookWidget {
  const KnittingPatternScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text('arrow'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.arrow_turn_up_left),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.arrow_turn_up_right))
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(scaffoldKey.currentState?.context ?? context)
              .viewPadding
              .bottom,
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // floatingActionButton
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // 選択した色にしたい
                  backgroundColor: Colors.pink[50],
                  foregroundColor: Colors.grey,
                  // 影なし
                  elevation: 0),
              onPressed: () {},
              child: const Text('pink'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Zoom In'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Zoom Out'),
            ),
            // floatingActionButton: FloatingActionButton(onPressed: _onTap())
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ConnectedKnittingPatternViewer(
          maxHeight: constraints.maxHeight,
        ),
      ),
    );
  }

  void _onTap() {}
}
