import 'package:flutter/material.dart';

class StitchPainter {
  static CustomPainter fine(Color color) => _FineStitchPainter(color);
  static CustomPainter flat(Color color) => _FlatStitchPainter(color);
  static CustomPainter singleCrochetKnit(Color color) =>
      _SingleCrochetKnitPainter(color);
  static CustomPainter singleCrochetPurl(Color color) =>
      _SingleCrochetPurlPainter(color);
  static CustomPainter singleCrochetBackLoopOnly(Color color) =>
      _SingleCrochetBackLoopOnlyPainter(color);
}

class _FineStitchPainter extends _TouchablePainter {
  _FineStitchPainter(super.color);

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

class _FlatStitchPainter extends _TouchablePainter {
  _FlatStitchPainter(super.color);

  final double strokeWidth = 30.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = color;

    path
      ..moveTo(0, 0)
      ..lineTo(size.width / 2 - strokeWidth / 2, size.height)
      ..lineTo(size.width / 2 + strokeWidth / 2, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - strokeWidth, 0)
      ..lineTo(size.width / 2, size.height - strokeWidth)
      ..lineTo(0 + strokeWidth, 0);

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
      ..moveTo(0, 0)
      ..lineTo(0, 0 + size.height / 3)
      ..lineTo(0 + strokeWidth / 4, 0 + size.height / 3)
      ..lineTo(size.width / 2 - strokeWidth / 2, size.height)
      ..lineTo(size.width / 2 + strokeWidth / 2, size.height)
      ..lineTo(size.width - strokeWidth / 4, 0 + size.height / 5)
      ..lineTo(size.width - strokeWidth, 0 + size.height / 5)
      ..lineTo(size.width / 2, size.height - strokeWidth)
      ..lineTo(0 + strokeWidth, 0 + size.height / 3)
      ..lineTo(size.width * 0.6, 0 + size.height / 3)
      ..lineTo(size.width * 0.6, 0);

    canvas.drawPath(path, painter);
  }
}

// 輪編みの細編み(single crochet)(裏)
class _SingleCrochetPurlPainter extends _TouchablePainter {
  _SingleCrochetPurlPainter(super.color);

  final double strokeWidth = 45.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = color;

    path
      ..moveTo(0, 0 + size.height * 2 / 5)
      ..lineTo(size.width / 2 - strokeWidth / 2, size.height)
      ..lineTo(size.width / 2 + strokeWidth / 2, size.height)
      ..lineTo(size.width - strokeWidth / 4, 0 + size.height * 2 / 5)
      ..lineTo(size.width, 0 + size.height * 2 / 5)
      ..lineTo(size.width, 0 + size.height * 1 / 5)
      // 本当はここに2本の区別の切り込みが入れられると嬉しい
      ..lineTo(size.width, 0)
      ..lineTo(-strokeWidth / 2, 0)
      ..lineTo(-strokeWidth / 2, 0 + size.height * 1 / 5)
      ..lineTo(size.width / 3, size.height * 1 / 5)
      ..lineTo(size.width / 3, size.height * 2 / 5)
      ..lineTo(0, size.height * 2 / 5);
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
