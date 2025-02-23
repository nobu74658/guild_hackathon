import 'package:flutter/material.dart';

class StitchPainter {
  static CustomPainter fine(Color color) => _FineStitchPainter(color);
  static CustomPainter flat(Color color) => _FlatStitchPainter(color);
}

class _FineStitchPainter extends _TouchablePainter {
  _FineStitchPainter(super.color);

  final double strokeWidth = 4.0;

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

  final double strokeWidth = 4.0;

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
