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
      appBar: AppBar(),
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
            ElevatedButton(
              onPressed: () {},
              child: const Text('Zoom In'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Zoom Out'),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => KnittingPatternViewer(
          maxHeight: constraints.maxHeight,
        ),
      ),
    );
  }
}
