import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/app/use_case/pick_image/connection.dart';
import 'package:knitting/common/use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pick_image_use_case.g.dart';

@riverpod
PickImageUseCase pickImageUseCase(Ref ref) {
  return PickImageUseCase();
}

class PickImageUseCase extends UseCase<void, Future<Uint8List?>> {
  @override
  Future<Uint8List?> call(void param) async {
    return AppImagePicker().call();
  }
}
