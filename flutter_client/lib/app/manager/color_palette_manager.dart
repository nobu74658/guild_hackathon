import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/infra/color_palette_interface.dart';
import 'package:knitting/infra/color_palette_repository.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_palette_manager.g.dart';

abstract class ColorPaletteManagerInterface {
  Stream<List<ColorPalette>> stream();
  void add({
    required List<Color> palette,
    required String label,
    required int order,
  });
  void update({
    required int id,
    required List<Color> palette,
    required String label,
    required int order,
  });
  void delete(int id);
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

  @override
  void add({
    required List<Color> palette,
    required String label,
    required int order,
  }) {
    repository.add(
      palette: palette,
      label: label,
      order: order,
    );
  }

  @override
  void update({
    required int id,
    required List<Color> palette,
    required String label,
    required int order,
  }) {
    repository.update(
      id: id,
      palette: palette,
      label: label,
      order: order,
    );
  }

  @override
  void delete(int id) => repository.delete(id);
}
