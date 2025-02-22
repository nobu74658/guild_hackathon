import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knitting/view/knitting_pattern/components/stitch.dart';

class KnittingPatternView extends StatelessWidget {
  const KnittingPatternView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomPaint Example')),
      body: Center(
        child: Stack(
          children: [
            for (var y = 0; y < 10; y++)
              for (var x = 0; x < 10; x++)
                _Stitch(
                  width: 100,
                  height: 100,
                  x: x,
                  y: y,
                  dxRatio: 1,
                  dyRatio: 1,
                ),
          ],
        ),
      ),
    );
  }
}

class _Stitch extends HookWidget {
  const _Stitch({
    required this.width,
    required this.height,
    required this.x,
    required this.y,
    required this.dxRatio,
    required this.dyRatio,
  });

  final double width;
  final double height;
  final int x;
  final int y;
  final double dxRatio;
  final double dyRatio;

  @override
  Widget build(BuildContext context) {
    final color = useState(Colors.red);

    return Positioned(
      left: x * width * dxRatio,
      top: y * height * dyRatio,
      child: SizedBox(
        width: width,
        height: height,
        child: GestureDetector(
          onTap: () {
            color.value = color.value == Colors.red ? Colors.blue : Colors.red;
          },
          child: CustomPaint(
            painter: StitchPainter.fine(color.value),
          ),
        ),
      ),
    );
  }
}
