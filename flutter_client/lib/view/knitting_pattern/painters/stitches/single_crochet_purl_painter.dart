part of '../stitch_painter.dart';

class _SingleCrochetPurlPainter extends AbstractStitchPainter {
  _SingleCrochetPurlPainter(super.data);

  @override
  Path _paintStitch() {
    path
      // 一番上の横の糸
      ..moveTo(
        width * 0.25 + dx + dxGap + certainWidthGap,
        height * 0.3 + dy + certainHeightGap,
      )
      // 1
      ..quadraticBezierTo(
        0 + dx + dxGap + certainWidthGap,
        height * 0.35 + dy + certainHeightGap,
        width * 0.01 + dx + dxGap + certainWidthGap,
        height * 0.2 + dy + certainHeightGap,
      )
      // 2
      ..quadraticBezierTo(
        width * 0.4 + dx + dxGap + certainWidthGap,
        -height * 0.1 + dy + certainHeightGap,
        width * 0.9 + dx + dxGap + certainWidthGap,
        0 + dy + certainHeightGap,
      )
      // 3
      ..quadraticBezierTo(
        width + dx + dxGap + certainWidthGap,
        height * 0.15 + dy + certainHeightGap,
        width * 0.9 + dx + dxGap + certainWidthGap,
        height * 0.2 + dy + certainHeightGap,
      )
      // 4
      ..quadraticBezierTo(
        width * 0.6 + dx + dxGap + certainWidthGap,
        height * 0.2 + dy + certainHeightGap,
        width * 0.4 + dx + dxGap + certainWidthGap,
        height * 0.27 + dy + certainHeightGap,
      )
      // 右上から中央の左斜めの糸
      // 10
      ..moveTo(
        width * 0.65 + dx + dxGap + certainWidthGap,
        height * 0.55 + dy + certainHeightGap,
      )
      // 11
      ..quadraticBezierTo(
        width * 0.45 + dx + dxGap + certainWidthGap,
        height * 0.7 + dy + certainHeightGap,
        width * 0.45 + dx + dxGap + certainWidthGap,
        height * 1.3 + dy + certainHeightGap,
      )
      // 12
      ..quadraticBezierTo(
        width * 0.5 + dx + dxGap + certainWidthGap,
        height * 1.4 + dy + certainHeightGap,
        width * 0.6 + dx + dxGap + certainWidthGap,
        height * 1.3 + dy + certainHeightGap,
      )
      // 13
      ..quadraticBezierTo(
        width * 0.9 + dx + dxGap + certainWidthGap,
        height * 0.8 + dy + certainHeightGap,
        width * 0.85 + dx + dxGap + certainWidthGap,
        height * 0.545 + dy + certainHeightGap,
      )
      // 左から中央の右斜めの糸
      // 14
      ..moveTo(
        0 + dx + dxGap + certainWidthGap,
        height * 0.5 + dy + certainHeightGap,
      )
      // 15
      ..quadraticBezierTo(
        -width * 0.05 + dx + dxGap + certainWidthGap,
        height * 0.6 + dy + certainHeightGap,
        width * 0.3 + dx + dxGap + certainWidthGap,
        height * 1.3 + dy + certainHeightGap,
      )
      // 16
      ..quadraticBezierTo(
        width * 0.4 + dx + dxGap + certainWidthGap,
        height * 1.4 + dy + certainHeightGap,
        width * 0.5 + dx + dxGap + certainWidthGap,
        height * 1.3 + dy + certainHeightGap,
      )
      // 17
      ..quadraticBezierTo(
        width * 0.45 + dx + dxGap + certainWidthGap,
        height * 0.8 + dy + certainHeightGap,
        width * 0.2 + dx + dxGap + certainWidthGap,
        height * 0.5 + dy + certainHeightGap,
      )
      // 18
      ..quadraticBezierTo(
        width * 0.1 + dx + dxGap + certainWidthGap,
        height * 0.4 + dy + certainHeightGap,
        0 + dx + dxGap + certainWidthGap,
        height * 0.5 + dy + certainHeightGap,
      );
    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため

    // 右の横の毛糸
    path
      // 5
      ..moveTo(width * 0.55 + dx + dxGap + certainWidthGap, height * 0.25 + dy)
      // 6
      ..quadraticBezierTo(
        width * 0.9 + dx + dxGap + certainWidthGap,
        height * 0.25 + dy + certainHeightGap,
        width * 1.3 + dx + dxGap + certainWidthGap,
        height * 0.3 + dy + certainHeightGap,
      )
      // 7
      ..quadraticBezierTo(
        width * 1.4 + dx + dxGap + certainWidthGap,
        height * 0.4 + dy + certainHeightGap,
        width * 1.3 + dx + dxGap + certainWidthGap,
        height * 0.5 + dy + certainHeightGap,
      )
      // 8
      ..quadraticBezierTo(
        width + dx + dxGap + certainWidthGap,
        height * 0.55 + dy + certainHeightGap,
        width * 0.6 + dx + dxGap + certainWidthGap,
        height * 0.55 + dy + certainHeightGap,
      )
      // 9
      ..quadraticBezierTo(
        width * 0.5 + dx + dxGap + certainWidthGap,
        height * 0.5 + dy + certainHeightGap,
        width * 0.55 + dx + dxGap + certainWidthGap,
        height * 0.25 + dy,
      );

    return path;
  }
}
