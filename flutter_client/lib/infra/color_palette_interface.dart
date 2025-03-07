import 'package:knitting/model/entities/color_palette.dart';

abstract class ColorPaletteRepositoryInterface {
  ColorPaletteRepositoryInterface();

  Stream<List<ColorPalette>> stream();
}
