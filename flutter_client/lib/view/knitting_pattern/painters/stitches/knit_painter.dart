part of '../stitch_painter.dart';

class _KnitPainter extends AbstractStitchPainter {
  _KnitPainter(super.data);

  @override
  Path _paintStitch() {
    path
      ..moveTo(dx + dxGap, dy) // Added dxGap
      // 1. 左上から中央
      ..quadraticBezierTo(
        width * 0.2 + dx + dxGap, // Added dxGap
        -height * 0.2 + dy,
        width * 0.35 + dx + dxGap, // Added dxGap
        height * 0.2 + dy,
      )
      // 2. 中央から右
      ..quadraticBezierTo(
        width / 2 + dx + dxGap, // Added dxGap
        height * 0.7 + dy,
        width * 0.65 + dx + dxGap, // Added dxGap
        height * 0.2 + dy,
      )
      // 3.
      ..quadraticBezierTo(
        width * 0.8 + dx + dxGap,
        -height * 0.2 + dy,
        width + dx + dxGap,
        dy,
      ) // Added dxGap
      // 4.
      ..quadraticBezierTo(
        width * 1.15 + dx + dxGap, // Added dxGap
        height * 0.2 + dy,
        width * 0.8 + dx + dxGap, // Added dxGap
        height * 0.7 + dy,
      )
      // 5
      ..quadraticBezierTo(
        width / 2 + dx + dxGap, // Added dxGap
        height * 1.15 + dy,
        width * 0.2 + dx + dxGap, // Added dxGap
        height * 0.7 + dy,
      )
      ..quadraticBezierTo(
        0 - width * 0.15 + dx + dxGap,
        height * 0.2 + dy,
        dx + dxGap,
        dy,
      ); // Added dxGap
    return path;
  }
}
