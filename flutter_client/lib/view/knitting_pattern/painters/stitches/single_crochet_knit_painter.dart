part of '../stitch_painter.dart';

// 曲線済み
// 斜行を考える必要あり
// 輪編みの細編み(single crochet)(表)
// ４号だと思うなら修正する必要あり
// ６号だと問題ない可能性もある
class _SingleCrochetKnitPainter extends AbstractStitchPainter {
  _SingleCrochetKnitPainter(super.data);

  @override
  Path _paintStitch() {
    path
      // 上下関係の改善が必要
      // 上の横の糸
      ..moveTo(
        width * 0.05 + dx + dxGap,
        height * 0.05 + dy,
      )
      // 1
      ..quadraticBezierTo(
        width * 0.75 + dx + dxGap,
        -height * 0.4 + dy,
        width * 1.4 + dx + dxGap,
        height * 0.1 + dy,
      )
      // 2
      ..quadraticBezierTo(
        width * 1.5 + dx + dxGap,
        height * 0.25 + dy,
        width * 1.25 + dx + dxGap,
        height * 0.3 + dy,
      )
      // 3
      ..quadraticBezierTo(
        width * 0.8 + dx + dxGap,
        -height * 0.15 + dy,
        width * 0.3 + dx + dxGap,
        height * 0.2 + dy,
      )
      // 4
      ..quadraticBezierTo(
        0 + dx + dxGap,
        height * 0.25 + dy,
        width * 0.05 + dx + dxGap,
        height * 0.05 + dy,
      );
    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため
    path
      // 4
      ..moveTo(
        width * 0.1 + dx + dxGap,
        height * 0.2 + dy,
      )
      // 5
      ..quadraticBezierTo(
        width * 0.2 + dx + dxGap,
        height * 0.8 + dy,
        width * 0.56 + dx + dxGap,
        height * 1.1 + dy,
      )
      // 6
      ..quadraticBezierTo(
        width * 0.75 + dx + dxGap,
        height * 1.1 + dy,
        width * 0.75 + dx + dxGap,
        height * 0.9 + dy,
      )
      // 7
      ..quadraticBezierTo(
        width * 0.6 + dx + dxGap,
        height * 0.4 + dy,
        width * 0.4 + dx + dxGap,
        height * 0.2 + dy,
      );
    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため

    // 右の縦の糸
    path
      // 8
      ..moveTo(
        width * 0.8 + dx + dxGap,
        height * 0.05 + dy,
      )
      // 9
      ..quadraticBezierTo(
        width * 0.7 + dx + dxGap,
        height * 0.5 + dy,
        width * 0.7 + dx + dxGap,
        height * 0.75 + dy,
      )
      // 10
      ..quadraticBezierTo(
        width * 0.85 + dx + dxGap,
        height * 1.1 + dy,
        width * 0.99 + dx + dxGap,
        height * 0.9 + dy,
      )
      // 11
      ..quadraticBezierTo(
        width * 1.1 + dx + dxGap,
        height * 0.3 + dy,
        width + dx + dxGap,
        height * 0.1 + dy,
      );
    path.addPath(path, Offset.zero); // 重なった部分が消えないようにするため

    return path;
  }
}
