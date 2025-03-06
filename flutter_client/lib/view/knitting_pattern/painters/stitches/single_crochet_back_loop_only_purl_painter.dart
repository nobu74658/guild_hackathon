part of '../stitch_painter.dart';

class _SingleCrochetBackLoopOnlyPurlPainter extends AbstractStitchPainter {
  _SingleCrochetBackLoopOnlyPurlPainter(super.data);

  @override
  Path _paintStitch() {
    // 縦：横＝10:10(表あみが9:10だから、裏あみは11:10くらいの高さだけど、ループがややこしいから、10:10)
    path
      ..moveTo(dx + -width * 0.05 + dxGap, dy + -height * 0.1)
      // 1
      ..quadraticBezierTo(
        dx + -width * 0.1 + dxGap,
        dy + height * 0,
        dx + width * 0.05 + dxGap,
        dy + height * 0.15,
      )
      // 2
      ..quadraticBezierTo(
        dx + width * 0.5 + dxGap,
        dy + height * 0.15,
        dx + width * 0.9 + dxGap,
        dy + height * 0.3,
      )
      // 3
      ..quadraticBezierTo(
        dx + width * 1.1 + dxGap,
        dy + height * 0.22,
        dx + width * 1.05 + dxGap,
        dy + height * 0.09,
      )
      // 4
      ..quadraticBezierTo(
        dx + width * 0.45 + dxGap,
        dy + -height * 0.15,
        dx + -width * 0.05 + dxGap,
        dy + -height * 0.1,
      );
    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため

    path
      // 5
      ..moveTo(dx + width * 0.55 + dxGap, dy + height * 0.25)
      // 6
      ..quadraticBezierTo(
        dx + width * 0.45 + dxGap,
        dy + height * 0.35,
        dx + width * 0.55 + dxGap,
        dy + height * 0.45,
      )
      // 7
      ..quadraticBezierTo(
        dx + width * 0.8 + dxGap,
        dy + height * 0.55,
        dx + width * 1.1 + dxGap,
        dy + height * 0.45,
      )
      // 8
      ..quadraticBezierTo(
        dx + width * 1.2 + dxGap,
        dy + height * 0.35,
        dx + width * 1.05 + dxGap,
        dy + height * 0.25,
      )
      // 9
      ..quadraticBezierTo(
        dx + width * 0.8 + dxGap,
        dy + height * 0.3,
        dx + width * 0.55 + dxGap,
        dy + height * 0.25,
      );
    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため

    path
      // 10
      ..moveTo(dx + width * 0.65 + dxGap, dy + height * 0.4)
      // 11
      ..quadraticBezierTo(
        dx + width * 0.6 + dxGap,
        dy + height * 0.7,
        dx + width * 0.4 + dxGap,
        dy + height * 0.95,
      )
      // 12
      ..quadraticBezierTo(
        dx + width * 0.38 + dxGap,
        dy + height * 0.9,
        dx + width * 0.6 + dxGap,
        dy + height * 0.95,
      )
      // 13
      ..quadraticBezierTo(
        dx + width * 0.7 + dxGap,
        dy + height * 0.8,
        dx + width * 0.9 + dxGap,
        dy + height * 0.4,
      );
    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため

    path
      // 14
      ..moveTo(dx + -width * 0.2 + dxGap, dy + height * 0.6)
      // 15
      ..quadraticBezierTo(
        dx + -width * 0.15 + dxGap,
        dy + height * 0.85,
        dx + width * 0.15 + dxGap,
        dy + height * 0.9,
      )
      // 16
      ..quadraticBezierTo(
        dx + width * 0.3 + dxGap,
        dy + height * 0.85,
        dx + width * 0.25 + dxGap,
        dy + height * 0.75,
      )
      // 17
      ..quadraticBezierTo(
        dx + width * 0.1 + dxGap,
        dy + height * 0.75,
        dx + -width * 0.1 + dxGap,
        dy + height * 0.5,
      )
      // 18
      ..quadraticBezierTo(
        dx + -width * 0.15 + dxGap,
        dy + height * 0.45,
        dx + -width * 0.2 + dxGap,
        dy + height * 0.6,
      );

    return path;
  }
}
