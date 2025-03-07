part of '../stitch_painter.dart';

// クロススティッチ用(刺繍)
// 後回し
class _PixelArtPainter extends AbstractStitchPainter {
  _PixelArtPainter(super.data);
  final double strokeWidth = 4.0;

  @override
  Path _paintStitch() {
    // 左上から反時計回りに一周
    path
      ..moveTo(dx + dxGap, dy)
      ..lineTo(dx + dxGap, dy + height)
      ..lineTo(dx + dxGap + width, dy + height)
      ..lineTo(dx + dxGap + width, dy);

    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため

    return path;
  }
}
