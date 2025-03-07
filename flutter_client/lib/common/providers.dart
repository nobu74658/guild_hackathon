import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:knitting/model/entities/project.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(Ref ref) => FirebaseFirestore.instance;

@Riverpod(keepAlive: true)
Future<Directory> getDir(Ref ref) async => getApplicationDocumentsDirectory();

@Riverpod(keepAlive: true)
Future<Isar> getIsar(Ref ref) async {
  final dir = await ref.read(getDirProvider.future);
  return Isar.open(
    [IsaColorPaletteSchema, IsaProjectSchema],
    directory: dir.path,
  );
}

@Riverpod(keepAlive: true)
Future<SharedPreferences> getSharedPreferences(Ref ref) async =>
    SharedPreferences.getInstance();
