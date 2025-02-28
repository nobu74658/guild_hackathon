import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knitting/model/types/color_palette_type.dart';
import 'package:knitting/model/types/create_type.dart';
import 'package:knitting/model/types/knitting_pattern_size.dart';
import 'package:knitting/model/types/knitting_type.dart';

class SettingDialog extends HookConsumerWidget {
  const SettingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createType = useState(CreateType.note);
    final selectedImage = useState<XFile?>(null);
    final selectedSize = useState(KnittingPatternSizeType.eight);
    final selectedKnittingType = useState(KnittingType.singleCrochet);
    final selectedColorPalette = useState(ColorPaletteType.first);

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
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
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
                value: selectedColorPalette.value,
                items: ColorPaletteType.values
                    .map(
                      (colorPalette) => DropdownMenuItem(
                        value: colorPalette,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(colorPalette.label),
                            Wrap(
                              children: colorPalette.paletteColors
                                  .map(
                                    (color) => Container(
                                      width: 20,
                                      height: 20,
                                      color: color,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
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
                        child: Text(sizeType.label),
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
              onPressed: () {
                // TODO(nobu): 入力項目のバリデーション
                Navigator.pop(context, {
                  'createType': createType.value,
                  'size': selectedSize.value,
                  'knittingType': selectedKnittingType.value,
                  'colorPalette': selectedColorPalette.value.paletteColors,
                  'image': selectedImage.value,
                });
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
  final XFile? selectedImage;

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
                Image.file(
                  File(selectedImage!.path),
                  width: 40,
                  height: 40,
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
