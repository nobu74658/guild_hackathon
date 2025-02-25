import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/knitting_pattern_manager.dart';
import 'package:knitting/view/knitting_pattern/components/stitch.dart';

class ConnectedKnittingPatternViewer extends ConsumerWidget {
  const ConnectedKnittingPatternViewer({
    required this.maxHeight,
    super.key,
  });

  final double maxHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<img.Image> image =
        ref.watch(knittingPatternManagerProvider).fetchImage();
    final Future<ui.Image> texture =
        ref.watch(knittingPatternManagerProvider).fetchTexture();

    final future = Future.wait([image, texture]);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final image = snapshot.data;
          if (image == null) {
            return const Center(child: Text('Failed to load image'));
          }
          return KnittingPatternViewer(
            maxHeight: maxHeight,
            image: snapshot.data![0] as img.Image,
            texture: snapshot.data![1] as ui.Image,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class KnittingPatternViewer extends HookWidget {
  const KnittingPatternViewer({
    super.key,
    required this.maxHeight,
    required this.image,
    required this.texture,
  });

  final double maxHeight;
  final img.Image image;
  final ui.Image texture;

  @override
  Widget build(BuildContext context) {
    final imageWidth = image.width;
    final imageHeight = image.height;

    const unitSize = 100.0;
    const dxRatio = 1.0;
    const dyRatio = 1.0;
    const margin = 100.0;

    final knittingWidth = unitSize * imageWidth * dxRatio;
    final knittingHeight = unitSize * imageHeight * dyRatio;

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
            for (var y = imageHeight - 1; y > -1; y--)
              for (var x = imageWidth - 1; x > -1; x--) ...{
                _Stitch(
                  width: unitSize,
                  height: unitSize,
                  x: x,
                  y: y,
                  dxRatio: dxRatio,
                  dyRatio: dyRatio,
                  pixel: image.getPixel(x, y),
                  texture: texture,
                  seed: x + y + x * y,
                ),
              },
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
    required this.pixel,
    required this.texture,
    required this.seed,
  });

  final double width;
  final double height;
  final int x;
  final int y;
  final double dxRatio;
  final double dyRatio;
  final img.Pixel pixel;
  final ui.Image texture;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final color = useState(
      Color.fromARGB(
        pixel.a.toInt(),
        pixel.r.toInt(),
        pixel.g.toInt(),
        pixel.b.toInt(),
      ),
    );

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
            painter: StitchPainter.singleCrochetPurl(
              StitchPainterData(
                color: color.value,
                texture: texture,
                seed: seed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
