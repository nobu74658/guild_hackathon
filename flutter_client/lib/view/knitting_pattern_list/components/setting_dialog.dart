import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knitting/model/create_type.dart';
import 'package:knitting/model/knitting_pattern_size.dart';
import 'package:knitting/model/knitting_type.dart';

class SettingDialog extends HookConsumerWidget {
  const SettingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createType = useState(CreateType.note);
    final selectedImage = useState<XFile?>(null);
    final selectedSize = useState(KnittingPatternSizeType.eight);
    final selectedKnittingPattern = useState(KnittingType.singleCrochet);

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
          const Divider(),
          // 編み地の種類選択
          ListTile(
            title: const Text(
              '編み地',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14),
            ),
            trailing: DropdownButton<KnittingType>(
              // 文字を右寄せにするためにAlign使ったら表示されなくなっちゃった
              value: selectedKnittingPattern.value,
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
                  selectedKnittingPattern.value = value;
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
                Navigator.pop(context, {
                  'size': selectedSize.value,
                  'knittingPattern': selectedKnittingPattern.value,
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
