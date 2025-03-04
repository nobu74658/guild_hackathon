import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  Future<Uint8List?> call() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    return image.readAsBytes();
  }
}
