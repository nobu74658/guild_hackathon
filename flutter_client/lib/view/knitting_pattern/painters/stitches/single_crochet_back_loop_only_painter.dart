part of '../stitch_painter.dart';

class _SingleCrochetBackLoopOnlyPainter extends AbstractStitchPainter {
  _SingleCrochetBackLoopOnlyPainter(super.data);

  @override
  Path _paintStitch() {
    // 縦：横＝9:10
    // 外側の形状
    final Path outerPath = Path()
      ..moveTo(dx + width * 0.05 + dxGap, dy + height * 2 / 9)
      // 1
      ..quadraticBezierTo(
        dx - width * 0.14 + dxGap,
        dy + height * 2.5 / 9,
        dx + width * 0.05 + dxGap,
        dy + height * 4 / 9,
      )
      // 2
      ..quadraticBezierTo(
        dx + width * 0.3 + dxGap,
        dy + height * 4.2 / 9,
        dx + width * 0.55 + dxGap,
        dy + height * 3.2 / 9,
      )
      // 3
      ..cubicTo(
        dx + width * 0.65 + dxGap,
        dy + height * 2.8 / 9,
        dx + width * 0.85 + dxGap,
        dy + height * 3.5 / 9,
        dx + width * 0.95 + dxGap,
        dy + height * 3 / 9,
      )
      // 15
      ..quadraticBezierTo(
        dx + width * 1.1 + dxGap,
        dy + height * 2.5 / 9,
        dx + width * 1.05 + dxGap,
        dy + height / 9,
      )
      // 14
      ..quadraticBezierTo(
        dx + width * 0.45 + dxGap,
        dy - height * 6 / 9,
        dx - width * 0.1 + dxGap,
        dy + height * 2.5 / 9,
      );

    // 内側の穴
    final innerHole = Path()
      //16
      ..moveTo(dx + width * 0.85 + dxGap, dy + height * 1 / 9)
      // 17
      ..quadraticBezierTo(
        dx + width * 0.6 + dxGap,
        dy - height * 0.3,
        dx + width * 0.15 + dxGap,
        dy + height * 1.8 / 9,
      )
      // 16
      ..quadraticBezierTo(
        dx + width * 0.5 + dxGap,
        dy + height * 1 / 9,
        dx + width * 0.85 + dxGap,
        dy + height * 1 / 9,
      );

    // ドーナツの形状を作成（外側 - 内側の穴）
    final Path donutPath =
        Path.combine(PathOperation.difference, outerPath, innerHole);

    // タップ判定用にpathを設定
    path.addPath(donutPath, Offset.zero); // pathにドーナツ形状を代入

    path
      // 6
      ..moveTo(dx + width * 0.3 + dxGap, dy + height * 0.3)
      // 7
      ..quadraticBezierTo(
        dx + width * 0.2 + dxGap,
        dy + height * 5 / 9,
        dx + width * 0.3 + dxGap,
        dy + height * 6 / 9,
      )
      // 8
      ..quadraticBezierTo(
        dx + width * 0.45 + dxGap,
        dy + height * 6.5 / 9,
        dx + width * 0.4 + dxGap,
        dy + height * 5 / 9,
      )
      // 9
      ..quadraticBezierTo(
        dx + width * 0.35 + dxGap,
        dy + height * 4.5 / 9,
        dx + width * 0.4 + dxGap,
        dy + height * 3 / 9,
      );

    path
      // 10
      ..moveTo(dx + width * 0.55 + dxGap, dy + height * 2.5 / 9)
      // 11
      ..quadraticBezierTo(
        dx + width * 0.5 + dxGap,
        dy + height * 5 / 9,
        dx + width * 0.55 + dxGap,
        dy + height * 8 / 9,
      )
      // 12
      ..quadraticBezierTo(
        dx + width * 0.65 + dxGap,
        dy + height * 9.5 / 9,
        dx + width * 0.75 + dxGap,
        dy + height * 8 / 9,
      )
      // 13
      ..quadraticBezierTo(
        dx + width * 0.8 + dxGap,
        dy + height * 5.5 / 9,
        dx + width * 0.75 + dxGap,
        dy + height * 2.5 / 9,
      );

    return path;
  }
}
