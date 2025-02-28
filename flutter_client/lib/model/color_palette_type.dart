import 'package:flutter/material.dart';

enum ColorPaletteType {
  first('パレット1', [
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.brown,
    Colors.black,
    Colors.teal,
  ]),
  second('パレット2', [
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
