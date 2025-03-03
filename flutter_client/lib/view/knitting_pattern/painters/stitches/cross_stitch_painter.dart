part of '../stitch_painter.dart';

// クロススティッチ用(刺繍)
// 後回し
class _CrossStitchPainter extends AbstractStitchPainter {
  _CrossStitchPainter(super.data);
  final double strokeWidth = 4.0;

  @override
  Path _paintStitch() {
    path
      ..moveTo(dx + dxGap + strokeWidth, dy)
      ..lineTo(dx + dxGap, dy + strokeWidth)
      ..lineTo(dx + dxGap + width / 2 - strokeWidth, dy + height / 2)
      ..lineTo(dx + dxGap, dy + height - strokeWidth)
      ..lineTo(dx + dxGap + strokeWidth, dy + height)
      ..lineTo(dx + dxGap + width / 2, dy + height / 2 + strokeWidth)
      ..lineTo(dx + dxGap + width - strokeWidth, dy + height)
      ..lineTo(dx + dxGap + width, dy + height - strokeWidth)
      ..lineTo(dx + dxGap + width / 2 + strokeWidth, dy + height / 2)
      ..lineTo(dx + dxGap + width, dy + strokeWidth)
      ..lineTo(dx + dxGap + width - strokeWidth, dy)
      ..lineTo(dx + dxGap + width / 2, dy + height / 2 - strokeWidth)
      ..lineTo(dx + dxGap + strokeWidth, dy);

    return path;
  }
}
