import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AppImagePicker {
  Future<Uint8List?> call() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image == null) {
      return null;
    }
    return image;
  }
}
