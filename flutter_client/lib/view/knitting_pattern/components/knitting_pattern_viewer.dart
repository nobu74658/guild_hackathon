import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/knitting_pattern_manager.dart';
import 'package:knitting/model/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/components/stitch.dart';

class ConnectedKnittingPatternViewer extends ConsumerWidget {
  const ConnectedKnittingPatternViewer({
    required this.maxHeight,
    required this.knittingType,
    required this.image,
    super.key,
  });

  final double maxHeight;
  final KnittingType knittingType;
  final img.Image image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<ui.Image> texture =
        ref.watch(knittingPatternManagerProvider).fetchTexture();

    return FutureBuilder(
      future: texture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return KnittingPatternViewer(
            maxHeight: maxHeight,
            knittingType: knittingType,
            image: image,
            texture: snapshot.data!,
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
    required this.maxHeight,
    required this.knittingType,
    required this.image,
    required this.texture,
    super.key,
  });

  final double maxHeight;
  final KnittingType knittingType;
  final img.Image image;
  final ui.Image texture;

  @override
  Widget build(BuildContext context) {
    final imageWidth = image.width;
    final imageHeight = image.height;

    final knittingWidth =
        knittingType.width * imageWidth * knittingType.dxRatio +
            knittingType.gapRatio * knittingType.width * (imageHeight - 1);
    final knittingHeight =
        knittingType.height * imageHeight * knittingType.dyRatio;

    final viewerController = useTransformationController();
    final deviceWidth = MediaQuery.of(context).size.width;
    final scale = deviceWidth / (knittingWidth + knittingType.width * 2);
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
        margin: EdgeInsets.all(knittingType.width),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        width: knittingWidth + knittingType.width * 0.6,
        height: knittingHeight + knittingType.height * 0.6,
        child: Stack(
          children: [
            for (int y = imageHeight - 1; y > -1; y--)
              for (int x = 0; x < imageWidth; x++) ...{
                _Stitch(
                  knittingType: knittingType,
                  x: knittingType.xIndex(x, y, imageWidth),
                  y: y,
                  pixel: image.getPixel(x, y),
                  texture: texture,
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
    required this.knittingType,
    required this.x,
    required this.y,
    required this.pixel,
    required this.texture,
  });

  final KnittingType knittingType;
  final int x;
  final int y;
  final img.Pixel pixel;
  final ui.Image texture;

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

    final painter = y.isEven ? knittingType.evenStitch : knittingType.oddStitch;

    return Positioned(
      right: (x + 0.1) * knittingType.width * knittingType.dxRatio +
          knittingType.gapRatio * knittingType.width * (y - 1),
      top: (y + 0.1) * knittingType.height * knittingType.dyRatio,
      child: SizedBox(
        width: knittingType.width,
        height: knittingType.height,
        child: GestureDetector(
          onTap: () {
            color.value = color.value == Colors.red ? Colors.blue : Colors.red;
          },
          child: CustomPaint(
            painter: painter(
              StitchPainterData(
                color: color.value,
                texture: texture,
                seed: x + y + x * y,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
