import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'color_palette.g.dart';

@collection
class IsaColorPalette {
  Id id = Isar.autoIncrement;

  List<IsarColor>? paletteColors;
  String? label;
  int? order;
}

@embedded
class IsarColor {
  int? a;
  int? r;
  int? g;
  int? b;
}

class ColorPalette {
  ColorPalette({
    required this.id,
    required this.paletteColors,
    required this.label,
    required this.order,
  });

  final int id;
  final List<Color> paletteColors;
  final String label;
  final int order;

  static ColorPalette? fromIsar(IsaColorPalette isar) {
    if (isar.paletteColors == null) {
      return null;
    }

    return ColorPalette(
      id: isar.id,
      paletteColors: isar.paletteColors!
          .map((e) => Color.fromARGB(e.a!, e.r!, e.g!, e.b!))
          .toList(),
      label: isar.label!,
      order: isar.order!,
    );
  }

  static ColorPalette mock = ColorPalette(
    id: 0,
    paletteColors: [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.brown,
      Colors.grey,
      Colors.black,
    ],
    label: 'モック',
    order: 0,
  );
}

extension ColorListExtension on List<Color> {
  List<IsarColor> toIsar() {
    return map((e) {
      return IsarColor()
        ..a = (e.a * 255).toInt()
        ..r = (e.r * 255).toInt()
        ..g = (e.g * 255).toInt()
        ..b = (e.b * 255).toInt();
    }).toList();
  }
}
