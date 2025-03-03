part of '../stitch_painter.dart';

class _SingleCrochetPurlPainter extends AbstractStitchPainter {
  _SingleCrochetPurlPainter(super.data);

  @override
  Path _paintStitch() {
    path
      // 一番上の横の糸
      ..moveTo(width * 0.25 + dx + dxGap, height * 0.3 + dy)
      // 1
      ..quadraticBezierTo(
        0 + dx,
        height * 0.35 + dy,
        width * 0.01 + dx,
        height * 0.3 + dy,
      )
      // 2
      ..quadraticBezierTo(
        width * 0.4 + dx,
        -height * 0.1 + dy,
        width * 0.9 + dx,
        0 + dy,
      )
      // 3
      ..quadraticBezierTo(
        width + dx,
        height * 0.15 + dy,
        width * 0.9 + dx,
        height * 0.2 + dy,
      )
      // 4
      ..quadraticBezierTo(
        width * 0.6 + dx,
        height * 0.2 + dy,
        width * 0.4 + dx,
        height * 0.27 + dy,
      )
      // 右上から中央の左斜めの糸
      // 10
      ..moveTo(width * 0.65 + dx, height * 0.55 + dy)
      // 11
      ..quadraticBezierTo(
        width * 0.45 + dx,
        height * 0.7 + dy,
        width * 0.45 + dx,
        height * 1.3 + dy,
      )
      // 12
      ..quadraticBezierTo(
        width * 0.5 + dx,
        height * 1.4 + dy,
        width * 0.6 + dx,
        height * 1.3 + dy,
      )
      // 13
      ..quadraticBezierTo(
        width * 0.9 + dx,
        height * 0.8 + dy,
        width * 0.85 + dx,
        height * 0.545 + dy,
      )
      // 左から中央の右斜めの糸
      // 14
      ..moveTo(0 + dx, height * 0.5 + dy)
      // 15
      ..quadraticBezierTo(
        -width * 0.05 + dx,
        height * 0.6 + dy,
        width * 0.3 + dx,
        height * 1.3 + dy,
      )
      // 16
      ..quadraticBezierTo(
        width * 0.4 + dx,
        height * 1.4 + dy,
        width * 0.5 + dx,
        height * 1.3 + dy,
      )
      // 17
      ..quadraticBezierTo(
        width * 0.45 + dx,
        height * 0.8 + dy,
        width * 0.2 + dx,
        height * 0.5 + dy,
      )
      // 18
      ..quadraticBezierTo(
        width * 0.1 + dx,
        height * 0.4 + dy,
        0 + dx,
        height * 0.5 + dy,
      );

    // 右の横の毛糸
    path
      // 5
      ..moveTo(width * 0.55 + dx, height * 0.38 + dy)
      // 6
      ..quadraticBezierTo(
        width * 0.9 + dx,
        height * 0.25 + dy,
        width * 1.3 + dx,
        height * 0.3 + dy,
      )
      // 7
      ..quadraticBezierTo(
        width * 1.4 + dx,
        height * 0.4 + dy,
        width * 1.3 + dx,
        height * 0.5 + dy,
      )
      // 8
      ..quadraticBezierTo(
        width + dx,
        height * 0.55 + dy,
        width * 0.6 + dx,
        height * 0.55 + dy,
      )
      // 9
      ..quadraticBezierTo(
        width * 0.55 + dx,
        height * 0.5 + dy,
        width * 0.55 + dx,
        height * 0.38 + dy,
      );

    return path;
  }
}
