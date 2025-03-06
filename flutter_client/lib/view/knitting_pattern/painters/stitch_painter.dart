import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/view/knitting_pattern/painters/knitting_painter.dart';

part 'stitches/cross_stitch_painter.dart';
part 'stitches/knit_painter.dart';
part 'stitches/single_crochet_back_loop_only_painter.dart';
part 'stitches/single_crochet_back_loop_only_purl_painter.dart';
part 'stitches/single_crochet_knit_painter.dart';
part 'stitches/single_crochet_purl_painter.dart';

class StitchPainterData {
  StitchPainterData({
    required this.x,
    required this.y,
    required this.knittingData,
    required this.painter,
  });

  final int x;
  final int y;
  final KnittingPainterData knittingData;
  final Paint painter;
}

class StitchPainter {
  static AbstractStitchPainter crossStitch(StitchPainterData data) =>
      _CrossStitchPainter(data);
  static AbstractStitchPainter knit(StitchPainterData data) =>
      _KnitPainter(data);
  static AbstractStitchPainter singleCrochetKnit(StitchPainterData data) =>
      _SingleCrochetKnitPainter(data);
  static AbstractStitchPainter singleCrochetPurl(StitchPainterData data) =>
      _SingleCrochetPurlPainter(data);
  static AbstractStitchPainter singleCrochetBackLoopOnly(
    StitchPainterData data,
  ) =>
      _SingleCrochetBackLoopOnlyPainter(data);
  static AbstractStitchPainter singleCrochetBackLoopOnlyPurl(
    StitchPainterData data,
  ) =>
      _SingleCrochetBackLoopOnlyPurlPainter(data);
}

abstract class AbstractStitchPainter {
  AbstractStitchPainter(this.data);

  final StitchPainterData data;

  double get width => data.knittingData.knittingType.width;
  double get height => data.knittingData.knittingType.height;
  double get certainWidthGap =>
      data.y.isEven ? data.knittingData.knittingType.certainWidthGap : 0;
  double get certainHeightGap =>
      data.y.isEven ? data.knittingData.knittingType.certainHeightGap : 0;
  double get dx => data.x * width;
  double get dy => data.y * height;
  double get dxGap =>
      data.knittingData.knittingType.gapRatio *
      data.knittingData.knittingType.width *
      data.knittingData.knittingType.dxRatio *
      (data.knittingData.image.height - data.y - 1);
  img.Pixel get pixel => data.knittingData.image.getPixel(data.x, data.y);
  Paint get unitPainter => data.painter
    ..color = Color.fromARGB(
      pixel.a.toInt(),
      pixel.r.toInt(),
      pixel.g.toInt(),
      pixel.b.toInt(),
    );

  final path = Path();

  (Path, Paint) paint() {
    final path = _paintStitch();
    return (path, unitPainter);
  }

  Path _paintStitch() {
    throw UnimplementedError();
  }
}
