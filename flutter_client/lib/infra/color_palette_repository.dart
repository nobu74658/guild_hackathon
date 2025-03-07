import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:knitting/common/providers.dart';
import 'package:knitting/infra/color_palette_interface.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'color_palette_repository.g.dart';

@Riverpod(keepAlive: true)
ColorPaletteRepositoryInterface colorPaletteRepository(Ref ref) =>
    _ColorPaletteRepository(
      ref.read(getIsarProvider.future),
      ref.read(getSharedPreferencesProvider.future),
    );

class _ColorPaletteRepository extends ColorPaletteRepositoryInterface {
  _ColorPaletteRepository(this._isar, this._sharedPreferences) {
    _sharedPreferences.then((value) {
      final isFirstSetup = value.getBool('color_palette_setup') ?? true;
      if (isFirstSetup) {
        value.setBool('color_palette_setup', false);
        add(
          palette: [
            Colors.white,
            Colors.grey,
            Colors.blueAccent,
            Colors.black,
            Colors.teal,
            Colors.yellow,
          ],
          label: 'パレット1',
          order: 1,
        );
        add(
          palette: [
            Colors.green,
            Colors.orange,
            Colors.pink,
            Colors.brown,
            Colors.black,
            Colors.teal,
          ],
          label: 'パレット2',
          order: 2,
        );
        add(
          palette: [
            Colors.yellow,
            Colors.red,
            Colors.blue,
            Colors.purple,
            Colors.grey,
            Colors.white,
          ],
          label: 'パレット3',
          order: 3,
        );
      }
    });
  }

  final Future<Isar> _isar;
  final Future<SharedPreferences> _sharedPreferences;

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
      ..order = order
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
