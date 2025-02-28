import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/knitting_pattern_manager.dart';
import 'package:knitting/common/use_case.dart';
import 'package:knitting/model/create_type.dart';
import 'package:knitting/model/knitting_pattern_size.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_new_pattern_use_case.g.dart';

class CreateNewPatternUseCaseParam {
  const CreateNewPatternUseCaseParam({
    required this.size,
    required this.image,
    required this.createType,
    required this.colorPalette,
  });

  final KnittingPatternSizeType size;
  final img.Image? image;
  final CreateType createType;
  final List<Color> colorPalette;
}

@riverpod
CreateNewPatternUseCase createNewPatternUseCase(Ref ref) =>
    CreateNewPatternUseCase(ref);

class CreateNewPatternUseCase
    extends UseCase<CreateNewPatternUseCaseParam, Future<img.Image>> {
  CreateNewPatternUseCase(this.ref);
  final Ref ref;

  @override
  Future<img.Image> call(CreateNewPatternUseCaseParam param) async {
    final image = param.createType == CreateType.note
        ? await _createImage(param.size, param.colorPalette)
        : await _convertToDotImage(param.size, param.image, param.colorPalette);
    return image;
  }

  Future<img.Image> _convertToDotImage(
    KnittingPatternSizeType size,
    img.Image? image,
    List<Color> colorPalette,
  ) async {
    // TODO(backend): ドット絵化APIを叩く(input: size, image, List<Color>)
    final image = await ref.read(knittingPatternManagerProvider).fetchImage();
    await Future.delayed(const Duration(seconds: 1));
    // 画像をドット絵化する処理
    return image;
  }

  Future<img.Image> _createImage(
    KnittingPatternSizeType size,
    List<Color> colorPalette,
  ) async {
    final image = img.Image(
      width: size.width,
      height: size.height,
    );
    return image;
  }
}
