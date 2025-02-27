import 'package:flutter/material.dart';
import 'package:knitting/view/knitting_pattern/components/stitch.dart';

class KnittingType {
  const KnittingType._({
    required this.oddStitch,
    required this.evenStitch,
  });

  static const KnittingType singleCrochet = KnittingType._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetPurl,
  );

  final CustomPainter Function(StitchPainterData) oddStitch;
  final CustomPainter Function(StitchPainterData) evenStitch;
  double get width => 100.0;
  double get height => 100.0;
  double get dxRatio => 1.0;
  double get dyRatio => 1.0;
}
