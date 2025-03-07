import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/infra/color_palette_interface.dart';
import 'package:knitting/infra/color_palette_repository.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_palette_manager.g.dart';

abstract class ColorPaletteManagerInterface {
  Stream<List<ColorPalette>> stream();
}

@riverpod
ColorPaletteManagerInterface colorPaletteManager(Ref ref) =>
    _ColorPaletteManager(
      repository: ref.watch(colorPaletteRepositoryProvider),
    );

class _ColorPaletteManager extends ColorPaletteManagerInterface {
  _ColorPaletteManager({required this.repository});

  final ColorPaletteRepositoryInterface repository;

  @override
  Stream<List<ColorPalette>> stream() => repository.stream();
}
