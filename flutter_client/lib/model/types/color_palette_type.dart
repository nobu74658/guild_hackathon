import 'package:flutter/material.dart';

enum ColorPaletteType {
  first('パレット1', [
    Colors.white,
    Colors.grey,
    Colors.blueAccent,
    Colors.black,
  ]),
  second('パレット2', [
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.brown,
    Colors.black,
    Colors.teal,
  ]),
  third('パレット3', [
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.grey,
    Colors.white,
  ]),
  ;

  const ColorPaletteType(this.label, this.paletteColors);

  final String label;
  final List<Color> paletteColors;
}
