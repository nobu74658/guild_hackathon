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

  int get _pixelCount => data.image.width * data.image.height;
  final List<Path> _pathList = [];

  final KnittingPainterData data;

  Paint get painter => Paint();

  @override
  void paint(Canvas canvas, Size size) {
    for (int y = 0; y < data.image.height; y++) {
      for (int x = 0; x < data.image.width; x++) {
        final isStartRight = y.isEven
            ? data.knittingType.isEvenRowStartRight
            : !data.knittingType.isEvenRowStartRight;
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

  int? getTappedIndex(Offset position) {
    for (int i = 0; i < _pixelCount; i++) {
      final x = i % data.image.width;
      final y = i ~/ data.image.width;
      final isStartRight = y.isEven
          ? data.knittingType.isEvenRowStartRight
          : !data.knittingType.isEvenRowStartRight;
      final xIndex = _xIndex(x, isStartRight);
      if (_pathList[y * data.image.width + xIndex].contains(position)) {
        return i;
      }
    }
    return null;
  }
}
