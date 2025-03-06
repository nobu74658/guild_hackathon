// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/model/types/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/components/grid_with_dividers.dart';
import 'package:knitting/view/knitting_pattern/knitting_pattern_screen.dart';
import 'package:knitting/view/knitting_pattern/painters/knitting_painter.dart';

class KnittingPatternViewer extends HookWidget {
  const KnittingPatternViewer({
    required this.maxHeight,
    required this.knittingType,
    required this.image,
    required this.texture,
    required this.selectedColor,
    required this.editModeType,
    required this.backgroundColor,
    super.key,
  });

  final double maxHeight;
  final KnittingType knittingType;
  final img.Image image;
  final ui.Image texture;
  final Color? backgroundColor;
  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<EditModeType> editModeType;

  @override
  Widget build(BuildContext context) {
    final imageWidth = image.width;
    final imageHeight = image.height;

    // Add state for grid customization
    final showGrid = useState(true);

    final knittingWidth =
        knittingType.width * imageWidth * knittingType.dxRatio +
            knittingType.gapRatio * knittingType.width * (imageHeight - 1);
    final knittingHeight =
        knittingType.height * imageHeight * knittingType.dyRatio;

    final viewerController = useTransformationController();
    final deviceWidth = MediaQuery.of(context).size.width;
    final scale = deviceWidth / (knittingWidth + knittingType.width * 2);

    void resetViewer() {
      final offset = Offset(0, maxHeight / scale / 2 - knittingHeight / 2);

      viewerController.value = Matrix4.identity()
        ..scale(scale)
        ..translate(offset.dx, offset.dy);

      return;
    }

    useEffect(
      () {
        resetViewer();
        return null;
      },
      [],
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'toggleGridNumbers',
            mini: true,
            onPressed: () => showGrid.value = !showGrid.value,
            child: const Icon(
              Icons.format_list_numbered,
              size: 20,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            mini: true,
            heroTag: 'resetView',
            onPressed: resetViewer,
            child: const Icon(
              Icons.replay_outlined,
              size: 20,
            ),
          ),
        ],
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(double.infinity),
        transformationController: viewerController,
        maxScale: 10,
        minScale: scale * 0.9,
        constrained: false,
        child: Padding(
          padding: const EdgeInsets.all(
            40,
          ), // Increase padding on all sides for numbers
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(knittingType.width),
                width: knittingWidth,
                height: knittingHeight,
                child: _Stitch(
                  image: image,
                  knittingType: knittingType,
                  imageWidth: imageWidth,
                  imageHeight: imageHeight,
                  texture: texture,
                  selectedColor: selectedColor,
                  editModeType: editModeType,
                ),
              ),
              if (showGrid.value)
                IgnorePointer(
                  child: Container(
                    margin: EdgeInsets.all(knittingType.width),
                    width: knittingWidth,
                    height: knittingHeight,
                    child: KnittingGridWithDividers(
                      totalRows: imageWidth,
                      totalColumns: imageHeight,
                      cellWidth: knittingType.width * knittingType.dxRatio,
                      cellHeight: knittingType.height * knittingType.dyRatio,
                      certainWidthGap: knittingType.certainHeightGap,
                      gapRatio: knittingType.gapRatio,
                      numberFontSize: 60.0, // Larger font size
                      numberPadding: 100.0, // More padding
                      regularNumberColor: Colors.black87,
                      specialNumberColor: Colors.red.shade800,
                      specialNumberFontSize: 60.0,
                      numberBackgroundOpacity: 0,
                    ),
                  ),
                ),
            ],
          ),
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
    required this.editModeType,
  });

  final img.Image image;
  final KnittingType knittingType;
  final int imageWidth;
  final int imageHeight;
  final ui.Image texture;
  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<EditModeType> editModeType;

  @override
  Widget build(BuildContext context) {
    final imageState = useState(image);
    DateTime? tapDownTime;

    final data = KnittingPainterData(
      knittingType: knittingType,
      image: imageState.value,
      texture: texture,
    );
    final painter = KnittingPainter(data);

    return SizedBox(
      width: imageWidth * knittingType.width * knittingType.dxRatio,
      height: imageHeight * knittingType.height * knittingType.dyRatio,
      child: GestureDetector(
        child: RepaintBoundary(
          child: CustomPaint(painter: painter),
        ),
        onTapDown: (TapDownDetails details) {
          tapDownTime = DateTime.now();
        },
        onTapUp: (TapUpDetails details) {
          if (tapDownTime == null) {
            return;
          }
          final Duration duration = DateTime.now().difference(tapDownTime!);
          if (duration.inMilliseconds > 300) {
            return;
          }

          final RenderBox renderBox = context.findRenderObject()! as RenderBox;
          final Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);

          final point = painter.getTappedIndex(localPosition);
          if (point != null) {
            if (editModeType.value == EditModeType.paint) {
              final img.Image newImage = imageState.value.clone();
              final color = img.ColorInt32.rgba(
                (selectedColor.value.r * 255).toInt(),
                (selectedColor.value.g * 255).toInt(),
                (selectedColor.value.b * 255).toInt(),
                (selectedColor.value.a * 255).toInt(),
              );
              newImage.setPixel(point.$1, point.$2, color);
              imageState.value = newImage;
            }
            if (editModeType.value == EditModeType.dropper) {
              final color = imageState.value.getPixel(
                point.$1,
                point.$2,
              );
              selectedColor.value = Color.fromARGB(
                color.a.toInt(),
                color.r.toInt(),
                color.g.toInt(),
                color.b.toInt(),
              );
            }
          }
        },
      ),
    );
  }
}
