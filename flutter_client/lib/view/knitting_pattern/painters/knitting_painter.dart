import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/model/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/painters/stitch_painter.dart';

class KnittingPainterData {
  KnittingPainterData({
    required this.knittingType,
    required this.image,
    required this.texture,
  });

  final KnittingType knittingType;
  final img.Image image;
  final ui.Image texture;
}

class KnittingPainter extends CustomPainter {
  KnittingPainter(this.data);

  int get _pixelCount => data.image.width * data.image.height;
  final List<Path> _pathList = [];

  final KnittingPainterData data;

  Paint get painter => Paint();
  // ..shader = ImageShader(
  //   data.texture,
  //   TileMode.repeated,
  //   TileMode.repeated,
  //   Matrix4.identity().storage,
  //   filterQuality: FilterQuality.low,
  // );

  @override
  void paint(Canvas canvas, Size size) {
    for (int y = 0; y < data.image.height; y++) {
      for (int x = 0; x < data.image.width; x++) {
        final stitchPainterData = StitchPainterData(
          x: x,
          y: y,
          knittingData: data,
          painter: painter,
        );
        final (path, unitPainter) = y.isEven
            ? data.knittingType.evenStitch(stitchPainterData).paint()
            : data.knittingType.oddStitch(stitchPainterData).paint();
        canvas.drawPath(path, unitPainter);
        _pathList.add(path);
      }
    }
  }

  @override
  bool shouldRepaint(KnittingPainter oldDelegate) {
    return true;
  }

  int? getTappedIndex(Offset position) {
    for (int i = 0; i < _pixelCount; i++) {
      if (_pathList[i].contains(position)) {
        return i;
      }
    }
    return null;
  }
}
