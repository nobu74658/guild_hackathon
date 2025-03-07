import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knitting/model/converter/color_converter.dart';

part 'color_palette.freezed.dart';
part 'color_palette.g.dart';

@freezed
abstract class ColorPalette with _$ColorPalette {
  const factory ColorPalette({
    required String colorColorPaletteId,
    required String label,
    @colorListConverter required List<Color> paletteColors,
    required int order,
  }) = _ColorPalette;

  const ColorPalette._();

  factory ColorPalette.fromJson(Map<String, dynamic> json) =>
      _$ColorPaletteFromJson(json);

  static String get collectionName => 'color_palettes';

  static ColorPalette get mock => const ColorPalette(
        colorColorPaletteId: 'colorPaletteId',
        label: 'label',
        paletteColors: [
          Colors.white,
          Colors.grey,
          Colors.blueAccent,
          Colors.black,
          Colors.teal,
          Colors.yellow,
        ],
        order: 0,
      );
}
