// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:knitting/view/knitting_pattern/components/stitch.dart';

class KnittingType {
  const KnittingType._({
    required this.oddStitch,
    required this.evenStitch,
    this.isOddRowStartsRight = true,
    this.isEvenRowStartsRight = true,
    this.width = 100,
    this.height = 100,
    this.dxRatio = 1.0,
    this.dyRatio = 1.0,
  });

  static const KnittingType singleCrochet = KnittingType._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetPurl,
    isEvenRowStartsRight: false,
  );

  final CustomPainter Function(StitchPainterData) oddStitch;
  final CustomPainter Function(StitchPainterData) evenStitch;
  final bool isOddRowStartsRight;
  final bool isEvenRowStartsRight;
  final double width;
  final double height;
  final double dxRatio;
  final double dyRatio;

  int stitchRowIndex(int x, int y, int maxWidth) {
    if (y.isEven) {
      return isEvenRowStartsRight ? maxWidth - x - 1 : x;
    } else {
      return isOddRowStartsRight ? maxWidth - x - 1 : x;
    }
  }
}
