import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/model/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/components/stitch.dart';

class KnittingPatternViewer extends HookWidget {
  const KnittingPatternViewer({
    required this.maxHeight,
    required this.knittingType,
    required this.image,
    required this.texture,
    required this.selectedColor,
    super.key,
  });

  final double maxHeight;
  final KnittingType knittingType;
  final img.Image image;
  final ui.Image texture;
  final Color selectedColor;

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
        width: knittingWidth, // TODO(nobu): 編み地の周囲に余白を追加
        height: knittingHeight,
        child: _Stitch(
          image: image,
          knittingType: knittingType,
          imageWidth: imageWidth,
          imageHeight: imageHeight,
          texture: texture,
          selectedColor: selectedColor,
        ),
      ),
    );
  }
}

class _Stitch extends HookWidget {
  const _Stitch({
    required this.image,
    required this.knittingType,
    required this.imageWidth,
    required this.imageHeight,
    required this.texture,
    required this.selectedColor,
  });

  final img.Image image;
  final KnittingType knittingType;
  final int imageWidth;
  final int imageHeight;
  final ui.Image texture;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final color = useState(
      List.generate(imageWidth * imageHeight, (_) => Colors.white),
    );

    final painter =
        imageHeight.isEven ? knittingType.evenStitch : knittingType.oddStitch;

    final SingleCrochetKnitPainter painter0 = SingleCrochetKnitPainter(
      StitchPainterData(
        image: image,
        knittingType: knittingType,
        colors: color.value,
        texture: texture,
      ),
    );

    return SizedBox(
      width: imageWidth * knittingType.width * knittingType.dxRatio,
      height: imageHeight * knittingType.height * knittingType.dyRatio,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          final RenderBox renderBox = context.findRenderObject()! as RenderBox;
          final Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);

          final int? index = painter0.getTappedIndex(localPosition);
          if (index != null) {
            color.value = List.generate(
              imageWidth * imageHeight,
              (i) => i == index ? selectedColor : color.value[i],
            );
          }
        },
        child: RepaintBoundary(
          child: CustomPaint(painter: painter0),
        ),
      ),
    );
  }
}
