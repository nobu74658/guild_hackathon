// ignore_for_file: unused_element
// 選択肢に表示される編み地

import 'package:knitting/view/knitting_pattern/painters/stitch_painter.dart';

enum KnittingType {
  singleCrochet._(
    oddStitch: StitchPainter.singleCrochetKnit,
    evenStitch: StitchPainter.singleCrochetPurl,
    label: '細編み（往復）',
    value: 'singleCrochet',
    certainWidthGap: 50,
    certainHeightGap: -15,
    height: 85,
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
    height: 110,
  ),
  knit._(
    oddStitch: StitchPainter.knit,
    evenStitch: StitchPainter.knit,
    label: 'メリヤス編み',
    value: 'knit',
    height: 85,
  ),
  // // Tは使ったことない、他の人の反応見ても需要は高くなさそう
  // singleCrochetPurl._(
  //   oddStitch: StitchPainter.singleCrochetPurl,
  //   evenStitch: StitchPainter.singleCrochetPurl,
  //   label: '細編み(裏あみ)',
  //   value: 'singleCrochet',
  // ),
  pixelArt._(
    oddStitch: StitchPainter.pixelArt,
    evenStitch: StitchPainter.pixelArt,
    label: 'ドット絵',
    value: 'pixelArt',
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
