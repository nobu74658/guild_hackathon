import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class StitchPainterData {
  StitchPainterData({
    required this.unitWidth,
    required this.color,
    required this.colors,
    required this.texture,
    required this.seed,
  });

  final double unitWidth;
  final Color color;
  final ui.Image texture;
  final int seed;
  final List<Color> colors;
}

class StitchPainter {
  static CustomPainter crossStitch(StitchPainterData data) =>
      _CrossStitchPainter(data);
  static CustomPainter knit(StitchPainterData data) => _KnitPainter(data);
  static SingleCrochetKnitPainter singleCrochetKnit(StitchPainterData data) =>
      SingleCrochetKnitPainter(data);
  static CustomPainter singleCrochetPurl(StitchPainterData data) =>
      _SingleCrochetPurlPainter(data);
  static CustomPainter singleCrochetBackLoopOnly(StitchPainterData data) =>
      _SingleCrochetBackLoopOnlyPainter(data);
  static CustomPainter singleCrochetBackLoopOnlyPurl(StitchPainterData data) =>
      _SingleCrochetBackLoopOnlyPurlPainter(data);
}

class _TouchablePainter extends CustomPainter {
  _TouchablePainter(this.data);
  final StitchPainterData data;

  final path = Path();
  Paint get painter => Paint()..color = data.color;
  // ..shader = ImageShader(
  //   data.texture,
  //   TileMode.repeated,
  //   TileMode.repeated,
  //   Matrix4.identity().storage,
  //   filterQuality: FilterQuality.low,
  // )
  // ..colorFilter = ColorFilter.mode(data.color, BlendMode.plus);

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

// メリヤス編み
class _KnitPainter extends _TouchablePainter {
  _KnitPainter(super.data);

  @override
  void paint(Canvas canvas, Size size) {
    path
      ..moveTo(0, 0)
      // 1. 左上から中央
      ..quadraticBezierTo(
        size.width * 0.2,
        -size.height * 0.2,
        size.width * 0.35,
        size.height * 0.2,
      )
      // 2. 中央から右
      ..quadraticBezierTo(
        size.width / 2,
        size.height * 0.7,
        size.width * 0.65,
        size.height * 0.2,
      )
      // 3.
      ..quadraticBezierTo(size.width * 0.8, -size.height * 0.2, size.width, 0)
      // 4.
      ..quadraticBezierTo(
        size.width * 1.15,
        size.height * 0.2,
        size.width * 0.8,
        size.height * 0.7,
      )
      // 5
      ..quadraticBezierTo(
        size.width / 2,
        size.height * 1.15,
        size.width * 0.2,
        size.height * 0.7,
      )
      ..quadraticBezierTo(0 - size.width * 0.15, size.height * 0.2, 0, 0);
    canvas.drawPath(path, painter);
  }
}

// 曲線済み
// 斜行を考える必要あり
// 輪編みの細編み(single crochet)(表)
class SingleCrochetKnitPainter extends _TouchablePainter {
  SingleCrochetKnitPainter(super.data);

  final List<double> dxList = [];
  final List<Path> pathList = [];

  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    dxList.clear();
    pathList.clear();

    for (double dx = 0; dx < size.width; dx += data.unitWidth * 1.5) {
      _paintUnit(canvas, size, dx);
    }
  }

  @override
  bool shouldRepaint(SingleCrochetKnitPainter oldDelegate) {
    return false;
  }

  @override
  bool hitTest(Offset position) {
    for (int i = 0; i < dxList.length; i++) {
      if (pathList[i].contains(position)) {
        print('Tapped dx index: $i'); // 何番目の dx か出力
        return true;
      }
    }
    return false;
  }

  /// **どの dx のパスがタップされたかを判定**
  int? getTappedIndex(Offset position) {
    for (int i = 0; i < dxList.length; i++) {
      if (pathList[i].contains(position)) {
        return i;
      }
    }
    return null;
  }

  void _paintUnit(Canvas canvas, Size size, double dx) {
    final Path path = Path();
    final painter = Paint()..color = data.colors[dxList.length];
    path
      // 上下関係の改善が必要
      // 上の横の糸
      ..moveTo(data.unitWidth * 0.05 + dx, size.height * 0.05)
      // 1
      ..quadraticBezierTo(
        data.unitWidth * 0.75 + dx,
        -size.height * 0.4,
        data.unitWidth * 1.4 + dx,
        size.height * 0.1,
      )
      // 2
      ..quadraticBezierTo(
        data.unitWidth * 1.5 + dx,
        size.height * 0.25,
        data.unitWidth * 1.25 + dx,
        size.height * 0.3,
      )
      // 3
      ..quadraticBezierTo(
        data.unitWidth * 0.8 + dx,
        -size.height * 0.15,
        data.unitWidth * 0.3 + dx,
        size.height * 0.2,
      )
      // 4
      ..quadraticBezierTo(
        0 + dx,
        size.height * 0.25,
        data.unitWidth * 0.05 + dx,
        size.height * 0.05,
      );

    path
      // 4
      ..moveTo(data.unitWidth * 0.1 + dx, size.height * 0.2)
      // 5
      ..quadraticBezierTo(
        data.unitWidth * 0.2 + dx,
        size.height * 0.8,
        data.unitWidth * 0.56 + dx,
        size.height * 1.1,
      )
      // 6
      ..quadraticBezierTo(
        data.unitWidth * 0.75 + dx,
        size.height * 1.1,
        data.unitWidth * 0.75 + dx,
        size.height * 0.9,
      )
      // 7
      ..quadraticBezierTo(
        data.unitWidth * 0.6 + dx,
        size.height * 0.4,
        data.unitWidth * 0.4 + dx,
        size.height * 0.2,
      );

    // 右の縦の糸
    path
      // 8
      ..moveTo(data.unitWidth * 0.8 + dx, size.height * 0.05)
      // 9
      ..quadraticBezierTo(
        data.unitWidth * 0.7 + dx,
        size.height * 0.5,
        data.unitWidth * 0.7 + dx,
        size.height * 0.75,
      )
      // 10
      ..quadraticBezierTo(
        data.unitWidth * 0.85 + dx,
        size.height * 1.1,
        data.unitWidth * 0.99 + dx,
        size.height * 0.9,
      )
      // 11
      ..quadraticBezierTo(
        data.unitWidth * 1.1 + dx,
        size.height * 0.3,
        data.unitWidth + dx,
        size.height * 0.1,
      );

    pathList.add(path);
    dxList.add(dx);
    canvas.drawPath(path, painter);
  }
}

// 輪編みの細編み(single crochet)(裏)
// 斜行の需要はそんなにないから、一旦、完成で問題ない
class _SingleCrochetPurlPainter extends _TouchablePainter {
  _SingleCrochetPurlPainter(super.data);

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

    // 右の横の毛糸
    path
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
  _SingleCrochetBackLoopOnlyPainter(super.color);

  @override
  void paint(Canvas canvas, Size size) {
    // 縦：横＝9:10
    // 外側の形状
    final Path outerPath = Path()
      ..moveTo(size.width * 0.05, size.height * 2 / 9)
      // 1
      ..quadraticBezierTo(
        -size.width * 0.14,
        size.height * 2.5 / 9,
        size.width * 0.05,
        size.height * 4 / 9,
      )
      // 2
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height * 4.2 / 9,
        size.width * 0.55,
        size.height * 3.2 / 9,
      )
      // 3
      ..cubicTo(
        size.width * 0.65,
        size.height * 2.8 / 9,
        size.width * 0.85,
        size.height * 3.5 / 9,
        size.width * 0.95,
        size.height * 3 / 9,
      )
      // 15
      ..quadraticBezierTo(
        size.width * 1.1,
        size.height * 2.5 / 9,
        size.width * 1.05,
        size.height / 9,
      )
      // 14
      ..quadraticBezierTo(
        size.width * 0.45,
        -size.height * 6 / 9,
        -size.width * 0.1,
        size.height * 2.5 / 9,
      );

    // 内側の穴
    final innerHole = Path()
      //16
      ..moveTo(size.width * 0.85, size.height * 1 / 9)
      // 17
      ..quadraticBezierTo(
        size.width * 0.6,
        -size.height * 0.3,
        size.width * 0.15,
        size.height * 1.8 / 9,
      )
      // 16
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 1 / 9,
        size.width * 0.85,
        size.height * 1 / 9,
      );

    // ドーナツの形状を作成（外側 - 内側の穴）
    final Path donutPath =
        Path.combine(PathOperation.difference, outerPath, innerHole);

    // タップ判定用にpathを設定
    path.addPath(donutPath, Offset.zero); // pathにドーナツ形状を代入

    path
      // 6
      ..moveTo(size.width * 0.3, size.height * 0.3)
      // 7
      ..quadraticBezierTo(
        size.width * 0.2,
        size.height * 5 / 9,
        size.width * 0.3,
        size.height * 6 / 9,
      )
      // 8
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 6.5 / 9,
        size.width * 0.4,
        size.height * 5 / 9,
      )
      // 9
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 4.5 / 9,
        size.width * 0.4,
        size.height * 3 / 9,
      );

    path
      // 10
      ..moveTo(size.width * 0.55, size.height * 2.5 / 9)
      // 11
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 5 / 9,
        size.width * 0.55,
        size.height * 8 / 9,
      )
      // 12
      ..quadraticBezierTo(
        size.width * 0.65,
        size.height * 9.5 / 9,
        size.width * 0.75,
        size.height * 8 / 9,
      )
      // 13
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 5.5 / 9,
        size.width * 0.75,
        size.height * 2.5 / 9,
      );

    canvas.drawPath(path, painter);
  }
}

// 往復編みのすじ編みのための裏あみ(single crochet back loop only　purl)
// 曲線の修正が必要
class _SingleCrochetBackLoopOnlyPurlPainter extends _TouchablePainter {
  _SingleCrochetBackLoopOnlyPurlPainter(super.color);

  @override
  void paint(Canvas canvas, Size size) {
    // 縦：横＝10:10(表あみが9:10だから、裏あみは11:10くらいの高さだけど、ループがややこしいから、10:10)
    path
      ..moveTo(-size.width * 0.05, -size.height * 0.1)
      // 1
      ..quadraticBezierTo(
        -size.width * 0.1,
        size.height * 0,
        size.width * 0.05,
        size.height * 0.15,
      )
      // 2
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.15,
        size.width * 0.9,
        size.height * 0.3,
      )
      // 3
      ..quadraticBezierTo(
        size.width * 1.1,
        size.height * 0.22,
        size.width * 1.05,
        size.height * 0.09,
      )
      // 4
      ..quadraticBezierTo(
        size.width * 0.45,
        -size.height * 0.15,
        -size.width * 0.05,
        -size.height * 0.1,
      );

    path
      // 5
      ..moveTo(size.width * 0.55, size.height * 0.25)
      // 6
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.35,
        size.width * 0.55,
        size.height * 0.45,
      )
      // 7
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.55,
        size.width * 1.1,
        size.height * 0.45,
      )
      // 8
      ..quadraticBezierTo(
        size.width * 1.2,
        size.height * 0.35,
        size.width * 1.05,
        size.height * 0.25,
      )
      // 9
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.3,
        size.width * 0.55,
        size.height * 0.25,
      );

    path
      // 10
      ..moveTo(size.width * 0.65, size.height * 0.4)
      // 11
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.7,
        size.width * 0.4,
        size.height * 0.95,
      )
      // 12
      ..quadraticBezierTo(
        size.width * 0.38,
        size.height * 0.9,
        size.width * 0.6,
        size.height * 0.95,
      )
      // 13
      ..quadraticBezierTo(
        size.width * 0.7,
        size.height * 0.8,
        size.width * 0.9,
        size.height * 0.4,
      );

    path
      // 14
      ..moveTo(-size.width * 0.2, size.height * 0.6)
      // 15
      ..quadraticBezierTo(
        -size.width * 0.15,
        size.height * 0.85,
        size.width * 0.15,
        size.height * 0.9,
      )
      // 16
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.85,
        size.width * 0.25,
        size.height * 0.75,
      )
      // 17
      ..quadraticBezierTo(
        size.width * 0.1,
        size.height * 0.75,
        -size.width * 0.1,
        size.height * 0.5,
      )
      // 18
      ..quadraticBezierTo(
        -size.width * 0.15,
        size.height * 0.45,
        -size.width * 0.2,
        size.height * 0.6,
      );

    canvas.drawPath(path, painter);
  }
}
