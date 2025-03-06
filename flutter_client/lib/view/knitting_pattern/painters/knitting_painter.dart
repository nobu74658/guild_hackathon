import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/model/types/knitting_type.dart';
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

  final List<Path> _pathList = [];

  final KnittingPainterData data;

  Paint get painter => Paint();

  @override
  void paint(Canvas canvas, Size size) {
    for (int y = data.image.height - 1; y > -1; y--) {
      for (int x = 0; x < data.image.width; x++) {
        final isStartRight = y.isEven
            ? data.knittingType.isEvenRowStartRight
            : data.knittingType.isOddRowStartRight;
        final stitchPainterData = StitchPainterData(
          x: _xIndex(x, isStartRight),
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

  int _xIndex(int x, bool isStartRight) {
    return isStartRight ? data.image.width - x - 1 : x;
  }

  @override
  bool shouldRepaint(KnittingPainter oldDelegate) {
    return true;
  }

  (int, int)? getTappedIndex(Offset position) {
    for (int y = 0; y < data.image.height; y++) {
      for (int x = 0; x < data.image.width; x++) {
        final isStartRight = y.isOdd
            ? data.knittingType.isEvenRowStartRight
            : data.knittingType.isOddRowStartRight;
        if (_pathList[y * data.image.width + x].contains(position)) {
          return (_xIndex(x, isStartRight), data.image.height - y - 1);
        }
      }
    }
    return null;
  }
}
