import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/state/color_palettes_state.dart';
import 'package:knitting/app/use_case/create_new_pattern_use_case.dart';
import 'package:knitting/app/use_case/pick_image_use_case.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:knitting/model/types/create_type.dart';
import 'package:knitting/model/types/knitting_pattern_size.dart';
import 'package:knitting/model/types/knitting_type.dart';

class ConnectedSettingDialog extends ConsumerWidget {
  const ConnectedSettingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPalettes = ref.watch(colorPalettesStateProvider);
    if (colorPalettes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Gap(16),
            Text(
              'カラーパレットを探しています...',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      );
    }
    return SettingDialog(colorPalettes: colorPalettes);
  }
}

class SettingDialog extends HookConsumerWidget {
  const SettingDialog({super.key, required this.colorPalettes});

  final List<ColorPalette> colorPalettes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColorPalette = useState(colorPalettes.firstOrNull);
    final createType = useState(CreateType.note);
    final selectedImage = useState<Uint8List?>(null);
    final selectedSize = useState(KnittingPatternSizeType.values.first);
    final selectedKnittingType = useState(KnittingType.singleCrochet);

    return AlertDialog(
      title: const Text(
        '編み図作成',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _CreateTypeSelectContainer(
                onTap: (type) => createType.value = type,
                createType: CreateType.note,
                selectedCreateType: createType.value,
              ),
              _CreateTypeSelectContainer(
                onTap: (type) async {
                  final image =
                      await ref.read(pickImageUseCaseProvider).call(null);
                  if (image == null) {
                    return;
                  }
                  selectedImage.value = image;
                  createType.value = type;
                },
                selectedImage: selectedImage.value,
                createType: CreateType.image,
                selectedCreateType: createType.value,
              ),
            ],
          ),
          const Divider(),
          _Content(
            label: 'パレット',
            widget: SizedBox(
              height: 60,
              child: DropdownButton(
                isExpanded: true,
                value: selectedColorPalette.value,
                items: colorPalettes.map(
                  (colorPalette) {
                    List<Color> colors = colorPalette.paletteColors;
                    if (colorPalette.paletteColors.length > 8) {
                      colors = colorPalette.paletteColors.sublist(0, 8);
                    }
                    return DropdownMenuItem(
                      value: colorPalette,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(colorPalette.label),
                          Expanded(
                            child: Wrap(
                              children: [
                                ...colors.map(
                                  (color) => Container(
                                    width: 20,
                                    height: 20,
                                    color: color,
                                  ),
                                ),
                                if (colorPalette.paletteColors.length > 8)
                                  const Text(' ...'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedColorPalette.value = value;
                  }
                },
              ),
            ),
          ),
          const Gap(8),
          // サイズ選択
          _Content(
            label: 'サイズ',
            widget: SizedBox(
              width: double.infinity,
              child: DropdownButton<KnittingPatternSizeType>(
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[800],
                ),
                isExpanded: true,
                value: selectedSize.value,
                items: KnittingPatternSizeType.values
                    .map(
                      (sizeType) => DropdownMenuItem(
                        value: sizeType,
                        child: Text('${sizeType.width} × ${sizeType.height}'),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedSize.value = value;
                  }
                },
              ),
            ),
          ),
          // 編み地の種類選択
          const Gap(8),
          _Content(
            label: '編み地',
            widget: DropdownButton<KnittingType>(
              isExpanded: true,
              // 文字を右寄せにするためにAlign使ったら表示されなくなっちゃった
              value: selectedKnittingType.value,
              items: KnittingType.values
                  .map(
                    (knittingPattern) => DropdownMenuItem(
                      value: knittingPattern,
                      child: Text(knittingPattern.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  selectedKnittingType.value = value;
                }
              },
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'キャンセル',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.indigo[400],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[400],
                elevation: 0,
              ),
              onPressed: selectedColorPalette.value == null
                  ? null
                  : () {
                      final image = selectedImage.value != null
                          ? img.decodeImage(selectedImage.value!)
                          : null;

                      final result = CreateNewPatternUseCaseParam(
                        size: selectedSize.value,
                        image: image,
                        createType: createType.value,
                        colorPalette: selectedColorPalette.value!.paletteColors,
                      );

                      Navigator.pop(
                        context,
                        (result, selectedKnittingType.value),
                      );
                    },
              child: const Text(
                '作成',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CreateTypeSelectContainer extends StatelessWidget {
  const _CreateTypeSelectContainer({
    required this.createType,
    required this.selectedCreateType,
    required this.onTap,
    this.selectedImage,
  });

  final CreateType createType;
  final CreateType selectedCreateType;
  final void Function(CreateType) onTap;
  final Uint8List? selectedImage;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onTap(createType),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: createType == selectedCreateType
                  ? Colors.black
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(createType.label),
              if (selectedImage != null)
                Image.memory(
                  selectedImage!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )
              else
                Icon(
                  createType.iconData,
                  color: Colors.grey[800],
                  size: 40,
                ),
            ],
          ),
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content({
    required this.label,
    required this.widget,
  });

  final String label;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          widget,
        ],
      ),
    );
  }
}
