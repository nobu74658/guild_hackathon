// ignore_for_file: unused_element

import 'package:knitting/view/knitting_pattern/painters/stitch_painter.dart';

enum KnittingType {
  singleCrochet._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetPurl,
    label: '細編み（往復）',
    value: 'singleCrochet',
    isEvenRowStartRight: false,
    height: 800,
  ),
  singleCrochetFrontLoop._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetKnit,
    label: '細編み（表, 輪）',
    value: 'singleCrochetFrontLoop',
    isEvenRowStartRight: false,
    isOddRowStartRight: false,
    width: 800,
    gapRatio: 1 / 8, // TODO(nobu): 負の値に対応する
  );

  const KnittingType._({
    required this.oddStitch,
    required this.evenStitch,
    required this.value,
    required this.label,
    this.isOddRowStartRight = true,
    this.isEvenRowStartRight = true,
    this.width = 1000,
    this.height = 1000,
    this.dxRatio = 1.0,
    this.dyRatio = 1.0,
    this.gapRatio = 0.0,
  });

  final AbstractStitchPainter Function(StitchPainterData data) oddStitch;
  final AbstractStitchPainter Function(StitchPainterData data) evenStitch;
  final String label;
  final String value;
  final bool isOddRowStartRight;
  final bool isEvenRowStartRight;
  final double width;
  final double height;
  final double dxRatio;
  final double dyRatio;
  final double gapRatio;

  static KnittingType fromValue(String value) {
    switch (value) {
      case 'singleCrochet':
        return KnittingType.singleCrochet;
      case 'singleCrochetFrontLoop':
        return KnittingType.singleCrochetFrontLoop;
      default:
        throw Exception('Unknown value: $value');
    }
  }
}
