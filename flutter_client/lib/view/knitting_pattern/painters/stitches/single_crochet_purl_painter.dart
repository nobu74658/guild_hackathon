part of '../stitch_painter.dart';

class _SingleCrochetPurlPainter extends AbstractStitchPainter {
  _SingleCrochetPurlPainter(super.data);
  final double widthGap = 500;
  final double heightGap = -150;

  @override
  Path _paintStitch() {
    path
      // 一番上の横の糸
      ..moveTo(
          width * 0.25 + dx + dxGap + widthGap, height * 0.3 + dy + heightGap)
      // 1
      ..quadraticBezierTo(
        0 + dx + dxGap + widthGap,
        height * 0.35 + dy + heightGap,
        width * 0.01 + dx + dxGap + widthGap,
        height * 0.3 + dy + heightGap,
      )
      // 2
      ..quadraticBezierTo(
        width * 0.4 + dx + dxGap + widthGap,
        -height * 0.1 + dy + heightGap,
        width * 0.9 + dx + dxGap + widthGap,
        0 + dy + heightGap,
      )
      // 3
      ..quadraticBezierTo(
        width + dx + dxGap + widthGap,
        height * 0.15 + dy + heightGap,
        width * 0.9 + dx + dxGap + widthGap,
        height * 0.2 + dy + heightGap,
      )
      // 4
      ..quadraticBezierTo(
        width * 0.6 + dx + dxGap + widthGap,
        height * 0.2 + dy + heightGap,
        width * 0.4 + dx + dxGap + widthGap,
        height * 0.27 + dy + heightGap,
      )
      // 右上から中央の左斜めの糸
      // 10
      ..moveTo(
          width * 0.65 + dx + dxGap + widthGap, height * 0.55 + dy + heightGap)
      // 11
      ..quadraticBezierTo(
        width * 0.45 + dx + dxGap + widthGap,
        height * 0.7 + dy + heightGap,
        width * 0.45 + dx + dxGap + widthGap,
        height * 1.3 + dy + heightGap,
      )
      // 12
      ..quadraticBezierTo(
        width * 0.5 + dx + dxGap + widthGap,
        height * 1.4 + dy + heightGap,
        width * 0.6 + dx + dxGap + widthGap,
        height * 1.3 + dy + heightGap,
      )
      // 13
      ..quadraticBezierTo(
        width * 0.9 + dx + dxGap + widthGap,
        height * 0.8 + dy + heightGap,
        width * 0.85 + dx + dxGap + widthGap,
        height * 0.545 + dy + heightGap,
      )
      // 左から中央の右斜めの糸
      // 14
      ..moveTo(0 + dx + dxGap + widthGap, height * 0.5 + dy + heightGap)
      // 15
      ..quadraticBezierTo(
        -width * 0.05 + dx + dxGap + widthGap,
        height * 0.6 + dy + heightGap,
        width * 0.3 + dx + dxGap + widthGap,
        height * 1.3 + dy + heightGap,
      )
      // 16
      ..quadraticBezierTo(
        width * 0.4 + dx + dxGap + widthGap,
        height * 1.4 + dy + heightGap,
        width * 0.5 + dx + dxGap + widthGap,
        height * 1.3 + dy + heightGap,
      )
      // 17
      ..quadraticBezierTo(
        width * 0.45 + dx + dxGap + widthGap,
        height * 0.8 + dy + heightGap,
        width * 0.2 + dx + dxGap + widthGap,
        height * 0.5 + dy + heightGap,
      )
      // 18
      ..quadraticBezierTo(
        width * 0.1 + dx + dxGap + widthGap,
        height * 0.4 + dy + heightGap,
        0 + dx + dxGap + widthGap,
        height * 0.5 + dy + heightGap,
      );
    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため

    // 右の横の毛糸
    path
      // 5
      ..moveTo(width * 0.55 + dx + dxGap + widthGap, height * 0.25 + dy)
      // 6
      ..quadraticBezierTo(
        width * 0.9 + dx + dxGap + widthGap,
        height * 0.25 + dy + heightGap,
        width * 1.3 + dx + dxGap + widthGap,
        height * 0.3 + dy + heightGap,
      )
      // 7
      ..quadraticBezierTo(
        width * 1.4 + dx + dxGap + widthGap,
        height * 0.4 + dy + heightGap,
        width * 1.3 + dx + dxGap + widthGap,
        height * 0.5 + dy + heightGap,
      )
      // 8
      ..quadraticBezierTo(
        width + dx + dxGap + widthGap,
        height * 0.55 + dy + heightGap,
        width * 0.6 + dx + dxGap + widthGap,
        height * 0.55 + dy + heightGap,
      )
      // 9
      ..quadraticBezierTo(
        width * 0.5 + dx + dxGap + widthGap,
        height * 0.5 + dy + heightGap,
        width * 0.55 + dx + dxGap + widthGap,
        height * 0.25 + dy,
      );

    return path;
  }
}
