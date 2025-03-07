import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/common/providers.dart';
import 'package:knitting/infra/color_palette_interface.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_palette_repository.g.dart';

@Riverpod(keepAlive: true)
ColorPaletteRepositoryInterface colorPaletteRepository(Ref ref) =>
    _ColorPaletteRepository(ref.read(firebaseFirestoreProvider));

class _ColorPaletteRepository extends ColorPaletteRepositoryInterface {
  _ColorPaletteRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<List<ColorPalette>> stream() {
    _firestore.collection('color_palettes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ColorPalette(
          colorColorPaletteId: doc.id,
          label: data['label'],
          paletteColors: data['paletteColors'],
          order: data['order'],
        );
      }).toList();
    });
    return Stream.value([]);
  }
}
