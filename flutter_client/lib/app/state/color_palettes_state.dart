import 'package:knitting/app/manager/color_palette_manager.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_palettes_state.g.dart';

@riverpod
class ColorPalettesState extends _$ColorPalettesState {
  @override
  List<ColorPalette> build() {
    final manager = ref.read(colorPaletteManagerProvider);
    manager.stream().listen((event) => state = event);

    return [];
  }
}
