// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:knitting/view/knitting_pattern/components/stitch.dart';

enum KnittingType {
  singleCrochet._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetPurl,
  ),
  singleCrochetFrontLoop._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetKnit,
    isEvenRowStartRight: false,
    isOddRowStartRight: false,
    gapRatio: 1 / 8, // TODO(nobu): 負の値に対応する
  );

  const KnittingType._({
    required this.oddStitch,
    required this.evenStitch,
    this.isOddRowStartRight = true,
    this.isEvenRowStartRight = true,
    this.width = 100,
    this.height = 100,
    this.dxRatio = 1.0,
    this.dyRatio = 1.0,
    this.gapRatio = 0.0,
  });

  final CustomPainter Function(StitchPainterData) oddStitch;
  final CustomPainter Function(StitchPainterData) evenStitch;
  final bool isOddRowStartRight;
  final bool isEvenRowStartRight;
  final double width;
  final double height;
  final double dxRatio;
  final double dyRatio;
  final double gapRatio;

  int xIndex(int x, int y, int maxWidth) {
    if (y.isEven) {
      return isEvenRowStartRight ? x : maxWidth - x - 1;
    } else {
      return isOddRowStartRight ? x : maxWidth - x - 1;
    }
  }
}
