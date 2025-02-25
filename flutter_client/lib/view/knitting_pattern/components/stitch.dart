import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class StitchPainterData {
  StitchPainterData({
    required this.color,
    required this.texture,
    required this.seed,
  });

  final Color color;
  final ui.Image texture;
  final int seed;
}

class StitchPainter {
  static CustomPainter crossStitch(StitchPainterData data) =>
      _CrossStitchPainter(data);
  static CustomPainter knit(StitchPainterData data) => _KnitPainter(data);
  static CustomPainter singleCrochetKnit(StitchPainterData data) =>
      _SingleCrochetKnitPainter(data);
  static CustomPainter singleCrochetPurl(StitchPainterData data) =>
      _SingleCrochetPurlPainter(data);
  static CustomPainter singleCrochetBackLoopOnly(StitchPainterData data) =>
      _SingleCrochetBackLoopOnlyPainter(data);
}

class _TouchablePainter extends CustomPainter {
  _TouchablePainter(this.data)
      : offsetX = Random(data.seed).nextDouble() * 100 + 100,
        offsetY = Random(data.seed).nextDouble() * 100 + 100;
  final StitchPainterData data;

  final path = Path();
  final double offsetX;
  final double offsetY;
  Matrix4 get _matrix => Matrix4.identity()..translate(-offsetX, -offsetY);
  Paint get painter => Paint()
    ..shader = ImageShader(
      data.texture,
      TileMode.repeated,
      TileMode.repeated,
      _matrix.storage,
      filterQuality: FilterQuality.high,
    )
    ..colorFilter = ColorFilter.mode(data.color, BlendMode.plus);

  @override
  void paint(Canvas canvas, Size size) {
    throw UnimplementedError();
  }

  @override
  bool shouldRepaint(_TouchablePainter oldDelegate) {
    // TODO(nobu): 編み方が変更された時にも再描画する
    return oldDelegate.data.color != data.color;
  }

  @override
  bool? hitTest(Offset position) {
    return path.contains(position);
  }
}

// クロススティッチ用(刺繍)
// 後回し
class _CrossStitchPainter extends _TouchablePainter {
  _CrossStitchPainter(super.data);

  final double strokeWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = data.color;

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
}

// strokeWidthを使わない修正が必要
class _KnitPainter extends _TouchablePainter {
  _KnitPainter(super.data);

  final double strokeWidth = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = data.color;

    path
      // 編み物的には時計回りで書いておくと重なった時の前後関係が自然(物による)
      ..moveTo(0, 0)
      // 1. 左上から中央
      ..quadraticBezierTo(
        size.width * 0.2,
        -size.height * 0.2,
        size.width / 2 - strokeWidth / 2,
        size.height * 0.2,
      )
      // 2. 中央から右
      ..quadraticBezierTo(
        size.width / 2,
        size.height - strokeWidth,
        size.width / 2 + strokeWidth / 2,
        size.height * 0.2,
      )
      // 3.
      ..quadraticBezierTo(size.width * 0.8, -size.height * 0.2, size.width, 0)
      // 4.
      ..quadraticBezierTo(
        size.width + strokeWidth / 2,
        size.height * 0.2,
        size.width / 2 + strokeWidth,
        size.height - strokeWidth,
      )
      // 5
      ..quadraticBezierTo(
        size.width / 2,
        size.height + strokeWidth / 2,
        size.width / 2 - strokeWidth,
        size.height - strokeWidth,
      )
      ..quadraticBezierTo(0 - strokeWidth / 2, size.height * 0.2, 0, 0);
    canvas.drawPath(path, painter);
  }
}

// 曲線済み
// 斜行を考える必要あり
// 輪編みの細編み(single crochet)(表)
class _SingleCrochetKnitPainter extends _TouchablePainter {
  _SingleCrochetKnitPainter(super.data);

  final double strokeWidth = 45.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = data.color;

    path
      // 上下関係の改善が必要
      // 上の横の糸
      ..moveTo(size.width * 0.05, size.height * 0.05)
      // 1
      // ..quadraticBezierTo(size.width * 0.35, -size.height * 0.3,
      //     size.width * 0.7, -size.height * 0.2)
      ..quadraticBezierTo(
        size.width * 0.75,
        -size.height * 0.4,
        size.width * 1.4,
        size.height * 0.1,
      )
      // 2
      ..quadraticBezierTo(size.width * 1.5, size.height * 0.25,
          size.width * 1.25, size.height * 0.3)
      // 3
      ..quadraticBezierTo(size.width * 0.8, -size.height * 0.15,
          size.width * 0.3, size.height * 0.2)
      // 4
      ..quadraticBezierTo(
          0, size.height * 0.25, size.width * 0.05, size.height * 0.05);
    //
    path
      // 4
      ..moveTo(size.width * 0.1, size.height * 0.2)
      // 5
      ..quadraticBezierTo(size.width * 0.2, size.height * 0.8,
          size.width * 0.56, size.height * 1.1)
      // 6
      ..quadraticBezierTo(size.width * 0.75, size.height * 1.1,
          size.width * 0.75, size.height * 0.9)
      // 7
      ..quadraticBezierTo(size.width * 0.6, size.height * 0.4, size.width * 0.4,
          size.height * 0.2);
    // 右の縦の糸
    path
      // 8
      ..moveTo(size.width * 0.8, size.height * 0.05)
      // 9
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.5, size.width * 0.7,
          size.height * 0.75)
      // 10
      ..quadraticBezierTo(size.width * 0.85, size.height * 1.1,
          size.width * 0.99, size.height * 0.9)
      // 11
      ..quadraticBezierTo(
          size.width * 1.1, size.height * 0.3, size.width, size.height * 0.1);
    canvas.drawPath(path, painter);
  }
}

// 輪編みの細編み(single crochet)(裏)
// 斜行の需要はそんなにないから、一旦、完成で問題ない
class _SingleCrochetPurlPainter extends _TouchablePainter {
  _SingleCrochetPurlPainter(super.data);

  final double strokeWidth = 45.0;

  @override
  void paint(Canvas canvas, Size size) {
    path
      // 一番上の横の糸
      ..moveTo(size.width * 0.25, size.height * 0.3)
      // 1
      ..quadraticBezierTo(
        0,
        size.height * 0.35,
        size.width * 0.01,
        size.height * 0.3,
      )
      // 2
      ..quadraticBezierTo(
        size.width * 0.4,
        -size.height * 0.1,
        size.width * 0.9,
        0,
      )
      // 3
      ..quadraticBezierTo(
        size.width,
        size.height * 0.15,
        size.width * 0.9,
        size.height * 0.2,
      )
      // 4
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.2,
        size.width * 0.4,
        size.height * 0.27,
      )
      // 右上から中央の左斜めの糸
      // 10
      ..moveTo(size.width * 0.65, size.height * 0.55)
      // 11
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.7,
        size.width * 0.45,
        size.height * 1.3,
      )
      // 12
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 1.4,
        size.width * 0.6,
        size.height * 1.3,
      )
      // 13
      ..quadraticBezierTo(
        size.width * 0.9,
        size.height * 0.8,
        size.width * 0.85,
        size.height * 0.545,
      )
      // 左から中央の右斜めの糸
      // 14
      ..moveTo(0, size.height * 0.5)
      // 15
      ..quadraticBezierTo(
        -size.width * 0.05,
        size.height * 0.6,
        size.width * 0.3,
        size.height * 1.3,
      )
      // 16
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 1.4,
        size.width * 0.5,
        size.height * 1.3,
      )
      // 17
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.8,
        size.width * 0.2,
        size.height * 0.5,
      )
      // 18
      ..quadraticBezierTo(
        size.width * 0.1,
        size.height * 0.4,
        0,
        size.height * 0.5,
      );
    path
      // 右の横の毛糸
      // 5
      ..moveTo(size.width * 0.55, size.height * 0.38)
      // 6
      ..quadraticBezierTo(
        size.width * 0.9,
        size.height * 0.25,
        size.width * 1.3,
        size.height * 0.3,
      )
      // 7
      ..quadraticBezierTo(
        size.width * 1.4,
        size.height * 0.4,
        size.width * 1.3,
        size.height * 0.5,
      )
      // 8
      ..quadraticBezierTo(
        size.width,
        size.height * 0.55,
        size.width * 0.6,
        size.height * 0.55,
      )
      // 9
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.5,
        size.width * 0.55,
        size.height * 0.38,
      );
    canvas.drawPath(path, painter);
  }
}

// 輪編みのすじ編み(single crochet back loop only)
// 曲線の修正が必要
class _SingleCrochetBackLoopOnlyPainter extends _TouchablePainter {
  _SingleCrochetBackLoopOnlyPainter(super.data);

  final double strokeWidth = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = data.color;

    path
      ..moveTo(0, 0)
      ..lineTo(0, 0 + size.height / 3)
      ..lineTo(10 + strokeWidth / 4, 0 + size.height / 3)
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
