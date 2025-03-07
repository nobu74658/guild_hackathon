// ignore_for_file: unused_element
// 選択肢に表示される編み地

import 'package:knitting/view/knitting_pattern/painters/stitch_painter.dart';

enum KnittingType {
  singleCrochet._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetPurl,
    label: '細編み（往復）',
    value: 'singleCrochet',
    isEvenRowStartRight: false,
    certainWidthGap: 50,
    certainHeightGap: -15,
    height: 80,
  ),
  singleCrochetFrontLoop._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetKnit,
    label: '細編み（表, 輪）',
    value: 'singleCrochetFrontLoop',
    isEvenRowStartRight: false,
    isOddRowStartRight: false,
    gapRatio: 1 / 8, // TODO(nobu): 負の値に対応する
  ),
  singleCrochetBackLoopOnly._(
    oddStitch: StitchPainter.singleCrochetBackLoopOnly,
    evenStitch: StitchPainter.singleCrochetBackLoopOnly,
    label: 'すじ編み',
    value: 'singleCrochetBackLoopOnly',
    height: 80,
  ),
  knit._(
    oddStitch: StitchPainter.knit,
    evenStitch: StitchPainter.knit,
    value: 'knit',
    label: 'メリヤス編み',
  ),
  // 不要なんだけど、見た目の確認のために表示
  singleCrochetPurl._(
    oddStitch: StitchPainter.singleCrochetPurl,
    evenStitch: StitchPainter.singleCrochetPurl,
    label: '細編み(裏あみ)',
    value: 'singleCrochet',
  ),
  ;

  const KnittingType._({
    required this.oddStitch,
    required this.evenStitch,
    required this.value,
    required this.label,
    this.isOddRowStartRight = true, //左右の重なり
    this.isEvenRowStartRight = true, //左右の重なり
    this.width = 100,
    this.height = 100,
    this.certainWidthGap = 0,
    this.certainHeightGap = 0,
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
  final double certainWidthGap;
  final double certainHeightGap;
  final double dxRatio;
  final double dyRatio;
  final double gapRatio;
}
