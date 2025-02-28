import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/knitting_pattern_manager.dart';
import 'package:knitting/common/use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_new_pattern_use_case.g.dart';

@riverpod
CreateNewPatternUseCase createNewPatternUseCase(Ref ref) =>
    CreateNewPatternUseCase(ref);

class CreateNewPatternUseCase extends UseCase<void, Future<img.Image>> {
  CreateNewPatternUseCase(this.ref);
  final Ref ref;

  @override
  Future<img.Image> call(void param) async {
    // TODO(backend): ドット絵化APIを叩く(input: size, image, List<Color>)
    final image = await ref.read(knittingPatternManagerProvider).fetchImage();
    await Future.delayed(const Duration(seconds: 1));

    return image;
  }
}
