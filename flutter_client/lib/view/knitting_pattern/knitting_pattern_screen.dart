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
            GestureDetector(
              onTap: () {
                print('検出');
              },
              child: Container(
                // color: Colors.blue,
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  // 選択中の色にしたい
                  color: Colors.pink[50],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // DecoratedBox(
            //   decoration: BoxDecoration(
            //     color: Colors.pink[50],
            //     borderRadius: BorderRadius.circular(2),
            //     border: Border.all(),
            //   ),
            //   child: const Text('pk'),
            // ),
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

  // void _onTap() {}
}
