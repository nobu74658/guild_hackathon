import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:knitting/common/providers.dart';
import 'package:knitting/infra/color_palette_interface.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_palette_repository.g.dart';

@Riverpod(keepAlive: true)
ColorPaletteRepositoryInterface colorPaletteRepository(Ref ref) =>
    _ColorPaletteRepository(ref.read(getIsarProvider.future));

class _ColorPaletteRepository extends ColorPaletteRepositoryInterface {
  _ColorPaletteRepository(this._isar);

  final Future<Isar> _isar;

  @override
  Stream<List<ColorPalette>> stream() async* {
    final isar = await _isar;
    final stream = isar.isaColorPalettes
        .buildQuery<IsaColorPalette>()
        .watch(fireImmediately: true);
    yield* stream.map(
      (event) => event
          .map((e) => ColorPalette.fromIsar(e))
          .toList()
          .whereType<ColorPalette>()
          .toList(),
    );
  }

  @override
  Future<void> add({
    required List<Color> palette,
    required String label,
    required int order,
  }) async {
    final isar = await _isar;
    final theme = IsaColorPalette()
      ..label = label
      ..order = 1
      ..paletteColors = palette.toIsar();
    await isar.writeTxn(() async {
      await isar.isaColorPalettes.put(theme);
    });
  }

  @override
  Future<void> update({
    required int id,
    required List<Color> palette,
    required String label,
    required int order,
  }) async {
    final isar = await _isar;
    final theme = IsaColorPalette()
      ..id = id
      ..label = label
      ..order = order
      ..paletteColors = palette.toIsar();
    await isar.writeTxn(() async {
      await isar.isaColorPalettes.put(theme);
    });
  }

  @override
  Future<void> delete(int id) async {
    final isar = await _isar;
    await isar.writeTxn(() async {
      await isar.isaColorPalettes.delete(id);
    });
  }
}
