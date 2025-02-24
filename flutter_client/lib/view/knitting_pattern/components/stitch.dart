import 'package:flutter/material.dart';

class StitchPainter {
  static CustomPainter crossStitch(Color color) => _CrossStitchPainter(color);
  static CustomPainter knit(Color color) => _KnitPainter(color);
  static CustomPainter singleCrochetKnit(Color color) =>
      _SingleCrochetKnitPainter(color);
  static CustomPainter singleCrochetPurl(Color color) =>
      _SingleCrochetPurlPainter(color);
  static CustomPainter singleCrochetBackLoopOnly(Color color) =>
      _SingleCrochetBackLoopOnlyPainter(color);
}

// クロススティッチ用(刺繍)
class _CrossStitchPainter extends _TouchablePainter {
  _CrossStitchPainter(super.color);

  final double strokeWidth = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = color;

    path
      ..moveTo(strokeWidth, 0)
      ..lineTo(0, strokeWidth)
      ..lineTo(size.width / 2 - strokeWidth, size.height / 2)
      ..lineTo(0, size.height - strokeWidth)
      ..lineTo(strokeWidth, size.height)
      ..lineTo(size.width / 2, size.height / 2 + strokeWidth)
      ..lineTo(size.width - strokeWidth, size.height)
      ..lineTo(size.width, size.height - strokeWidth)
      ..lineTo(size.width / 2 + strokeWidth, size.height / 2)
      ..lineTo(size.width, strokeWidth)
      ..lineTo(size.width - strokeWidth, 0)
      ..lineTo(size.width / 2, size.height / 2 - strokeWidth)
      ..lineTo(strokeWidth, 0);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool? hitTest(Offset position) {
    return path.contains(position);
  }
}

class _KnitPainter extends _TouchablePainter {
  _KnitPainter(super.color);

  final double strokeWidth = 30.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = color;

    path
      // 編み物的には時計回りで書いておくと重なった時の前後関係が自然(物による)
      ..moveTo(0, 0)
      // 1. 左上から中央
      ..quadraticBezierTo(size.width * 0.2, -size.height * 0.2,
          size.width / 2 - strokeWidth / 2, size.height * 0.2)
      // 2. 中央から右
      ..quadraticBezierTo(size.width / 2, size.height - strokeWidth,
          size.width / 2 + strokeWidth / 2, size.height * 0.2)
      // 3.
      ..quadraticBezierTo(size.width * 0.8, -size.height * 0.2, size.width, 0)
      // 4.
      ..quadraticBezierTo(size.width + strokeWidth / 2, size.height * 0.2,
          size.width / 2 + strokeWidth, size.height - strokeWidth)
      // 5
      ..quadraticBezierTo(size.width / 2, size.height + strokeWidth / 2,
          size.width / 2 - strokeWidth, size.height - strokeWidth)
      ..quadraticBezierTo(0 - strokeWidth / 2, size.height * 0.2, 0, 0);
    canvas.drawPath(path, painter);
  }
}

class _TouchablePainter extends CustomPainter {
  _TouchablePainter(this.color);
  final Color color;

  final path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    throw UnimplementedError();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool? hitTest(Offset position) {
    return path.contains(position);
  }
}

// 輪編みの細編み(single crochet)(表)
class _SingleCrochetKnitPainter extends _TouchablePainter {
  _SingleCrochetKnitPainter(super.color);

  final double strokeWidth = 45.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = color;

    path
      // 上下関係の改善が必要
      ..moveTo(size.width * 0.2, size.height * 0.3)
      // 1
      ..quadraticBezierTo(
          0, size.height * 0.3, size.width * 0.1, size.height * 0.2)
      // 2
      ..quadraticBezierTo(size.width * 0.5, -size.height * 0.15,
          size.width * 0.7, size.height * 0.0)
      // 3
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.1,
          size.width * 0.7, size.height * 0.1)
      // 4
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.3,
          size.width * 0.35, size.height * 0.3)
      // 5
      ..quadraticBezierTo(size.width * 0.67, size.height * 0.65,
          size.width * 0.7, size.height * 0.9)
      // 6
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.5, size.width * 0.8,
          size.height * 0.1)
      // 7
      ..quadraticBezierTo(
          size.width * 0.9, size.height * 0.05, size.width, size.height * 0.1)
      // 8
      ..quadraticBezierTo(size.width * 1.02, size.height * 0.7,
          size.width * 0.9, size.height * 0.9)
      // 9
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.95,
          size.width * 0.7, size.height * 0.9)
      // 10
      ..quadraticBezierTo(
          size.width * 0.7, size.height * 1, size.width * 0.55, size.height * 1)
      // 11
      ..quadraticBezierTo(size.width * 0.08, size.height * 0.55,
          size.width * 0.07, size.height * 0.25);
    // ..lineTo(0, 0 + size.height / 3)
    // ..lineTo(0 + strokeWidth / 4, 0 + size.height / 3)
    // ..lineTo(size.width / 2 - strokeWidth / 2, size.height)
    // ..lineTo(size.width / 2 + strokeWidth / 2, size.height)
    // ..lineTo(size.width - strokeWidth / 4, 0 + size.height / 5)
    // ..lineTo(size.width - strokeWidth, 0 + size.height / 5)
    // ..lineTo(size.width / 2, size.height - strokeWidth)
    // ..lineTo(0 + strokeWidth, 0 + size.height / 3)
    // ..lineTo(size.width * 0.6, 0 + size.height / 3)
    // ..lineTo(size.width * 0.6, 0);

    canvas.drawPath(path, painter);
  }
}

// 輪編みの細編み(single crochet)(裏)
// 重なり方の改善が必要
class _SingleCrochetPurlPainter extends _TouchablePainter {
  _SingleCrochetPurlPainter(super.color);

  final double strokeWidth = 45.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = color;

    path
      // 一番上の横の糸
      ..moveTo(size.width * 0.25, size.height * 0.3)
      // 1
      ..quadraticBezierTo(
          0, size.height * 0.35, size.width * 0.01, size.height * 0.3)
      // 2
      ..quadraticBezierTo(
          size.width * 0.4, -size.height * 0.1, size.width * 0.9, 0)
      // 3
      ..quadraticBezierTo(
          size.width, size.height * 0.15, size.width * 0.9, size.height * 0.2)
      // 4
      ..quadraticBezierTo(size.width * 0.6, size.height * 0.2, size.width * 0.4,
          size.height * 0.27)
      // 右上から中央の左斜めの糸
      // 10
      ..moveTo(size.width * 0.65, size.height * 0.55)
      // 11
      ..quadraticBezierTo(size.width * 0.45, size.height * 0.7,
          size.width * 0.45, size.height * 1.3)
      // 12
      ..quadraticBezierTo(size.width * 0.5, size.height * 1.4, size.width * 0.6,
          size.height * 1.3)
      // 13
      ..quadraticBezierTo(size.width * 0.9, size.height * 0.8,
          size.width * 0.85, size.height * 0.545)
      // 左から中央の右斜めの糸
      // 14
      ..moveTo(0, size.height * 0.5)
      // 15
      ..quadraticBezierTo(-size.width * 0.05, size.height * 0.6,
          size.width * 0.3, size.height * 1.3)
      // 16
      ..quadraticBezierTo(size.width * 0.4, size.height * 1.4, size.width * 0.5,
          size.height * 1.3)
      // 17
      ..quadraticBezierTo(size.width * 0.45, size.height * 0.8,
          size.width * 0.2, size.height * 0.5)
      // 18
      ..quadraticBezierTo(
          size.width * 0.1, size.height * 0.4, 0, size.height * 0.5);
    path
      // 右の横の毛糸
      // 5
      ..moveTo(size.width * 0.55, size.height * 0.38)
      // 6
      ..quadraticBezierTo(size.width * 0.9, size.height * 0.25,
          size.width * 1.3, size.height * 0.3)
      // 7
      ..quadraticBezierTo(size.width * 1.4, size.height * 0.4, size.width * 1.3,
          size.height * 0.5)
      // 8
      ..quadraticBezierTo(
          size.width, size.height * 0.55, size.width * 0.6, size.height * 0.55)
      // 9
      ..quadraticBezierTo(size.width * 0.55, size.height * 0.5,
          size.width * 0.55, size.height * 0.38);
    canvas.drawPath(path, painter);
  }
}

// 輪編みのすじ編み(single crochet back loop only)
class _SingleCrochetBackLoopOnlyPainter extends _TouchablePainter {
  _SingleCrochetBackLoopOnlyPainter(super.color);

  final double strokeWidth = 45.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = color;

    path
      ..moveTo(0, 0)
      ..lineTo(0, 0 + size.height / 3)
      ..lineTo(0 + strokeWidth / 4, 0 + size.height / 3)
      ..lineTo(size.width / 2 - strokeWidth / 2, size.height)
      ..lineTo(size.width / 2 + strokeWidth / 2, size.height)
      ..lineTo(size.width - strokeWidth / 4, 0 + size.height / 3)
      ..lineTo(size.width - strokeWidth, 0 + size.height / 3)
      ..lineTo(size.width / 2, size.height - strokeWidth)
      ..lineTo(0 + strokeWidth, 0 + size.height / 3)
      ..lineTo(size.width, 0 + size.height / 3)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, painter);
  }
}
