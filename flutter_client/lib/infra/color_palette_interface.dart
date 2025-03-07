import 'package:flutter/material.dart';
import 'package:knitting/model/entities/color_palette.dart';

abstract class ColorPaletteRepositoryInterface {
  ColorPaletteRepositoryInterface();

  Stream<List<ColorPalette>> stream();
  Future<void> add({
    required List<Color> palette,
    required String label,
    required int order,
  });
  Future<void> update({
    required int id,
    required List<Color> palette,
    required String label,
    required int order,
  });
  Future<void> delete(int id);
}
