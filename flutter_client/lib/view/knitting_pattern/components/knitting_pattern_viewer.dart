import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knitting/view/knitting_pattern/components/stitch.dart';

class KnittingPatternViewer extends HookWidget {
  const KnittingPatternViewer({
    super.key,
    required this.maxHeight,
  });

  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    const xCount = 20;
    const yCount = 40;
    const dxRatio = 1.0;
    const dyRatio = 0.5;
    const margin = 8.0;

    final knittingWidth = 20 * xCount.toDouble() * dxRatio;
    final knittingHeight = 20 * yCount.toDouble() * dyRatio;

    final viewerController = useTransformationController();
    final deviceWidth = MediaQuery.of(context).size.width;
    final scale = deviceWidth / (knittingWidth + margin * 2);
    useEffect(
      () {
        final offset = Offset(0, maxHeight / scale / 2 - knittingHeight / 2);

        viewerController.value = Matrix4.identity()
          ..scale(scale)
          ..translate(offset.dx, offset.dy);

        return null;
      },
      [],
    );

    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      transformationController: viewerController,
      maxScale: 10,
      minScale: scale * 0.9,
      constrained: false,
      child: Container(
        margin: const EdgeInsets.all(margin),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        width: knittingWidth,
        height: knittingHeight,
        child: Stack(
          children: [
            for (var y = 0; y < yCount; y++)
              for (var x = 0; x < xCount; x++)
                _Stitch(
                  width: knittingWidth / xCount,
                  height: knittingWidth / xCount,
                  x: x,
                  y: y,
                  dxRatio: dxRatio,
                  dyRatio: dyRatio,
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
            painter: StitchPainter.flat(color.value),
          ),
        ),
      ),
    );
  }
}
