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

        // 編み目以外の部分にタップ判定を付与するためのPath
        final width = data.knittingType.width;
        final height = data.knittingType.height;
        final dx = _xIndex(x, isStartRight) * width;
        final dy = y * height;
        final dxGap = data.knittingType.gapRatio *
            data.knittingType.width *
            data.knittingType.dxRatio *
            (data.image.height - y - 1);
        final certainWidthGap =
            y.isEven ? data.knittingType.certainWidthGap : 0;
        final certainHeightGap =
            y.isEven ? data.knittingType.certainHeightGap : 0;
        path.moveTo(dx + dxGap + certainWidthGap, dy + certainHeightGap);
        path.lineTo(
          dx + width + dxGap + certainWidthGap,
          dy + certainHeightGap,
        );
        path.lineTo(
          dx + width + dxGap + certainWidthGap,
          dy + certainHeightGap + height,
        );
        path.lineTo(
          dx + dxGap + certainWidthGap,
          dy + certainHeightGap + height,
        );
        path.close();

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
        final isStartRight = y.isEven // TODO(nobu): image sizeとの関係を考慮
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
