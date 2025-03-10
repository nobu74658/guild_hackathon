import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_image_manager.g.dart';

@riverpod
AssetImageManager assetImageManager(Ref ref) => AssetImageManager();

class AssetImageManager {
  AssetImageManager();

  Future<img.Image> fetchImage() async {
    final data = await rootBundle.load('assets/images/penguin.png');
    final bytes = data.buffer.asUint8List();
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Failed to load image');
    }
    return image;
  }

  Future<ui.Image> fetchTexture() async {
    final ByteData data = await rootBundle.load('assets/images/texture.png');
    final Uint8List list = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(list, (ui.Image img) => completer.complete(img));
    return completer.future;
  }
}
