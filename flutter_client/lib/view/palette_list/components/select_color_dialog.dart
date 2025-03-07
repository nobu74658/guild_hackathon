import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knitting/app/manager/color_palette_manager.dart';

class SelectColorDialog extends HookConsumerWidget {
  const SelectColorDialog({
    required this.id,
    required this.paletteName,
    required this.colorPalette,
    required this.isEdit,
    super.key,
  });

  final int? id;
  final String paletteName;
  final List<Color> colorPalette;
  final bool isEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = useState<Color>(Colors.blue);
    final colorPaletteState = useState<List<Color>>(colorPalette);
    final paletteNameController = useTextEditingController(text: paletteName);

    return AlertDialog(
      title: Text(
        'パレットを${isEdit ? '編集' : '追加'}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: paletteNameController,
              decoration: const InputDecoration(
                labelText: 'パレット名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ColorPicker(
              paletteType: PaletteType.hueWheel,
              pickerColor: colorState.value,
              onColorChanged: (newColor) => colorState.value = newColor,
              enableAlpha: false,
              labelTypes: const [],
              displayThumbColor: true,
              pickerAreaHeightPercent: 0.8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    children: colorPaletteState.value
                        .map(
                          (color) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('選択した色を削除しますか？'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('キャンセル'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            bool isDeleted = false;
                                            colorPaletteState.value =
                                                colorPaletteState.value
                                                    .where((c) {
                                              if (c == color && !isDeleted) {
                                                isDeleted = true;
                                                return false;
                                              }
                                              return true;
                                            }).toList();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('削除'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: color,
                                radius: 16,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      colorPaletteState.value = [
                        ...colorPaletteState.value,
                        colorState.value,
                      ];
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _isValid(
            colorPaletteState.value,
            paletteNameController.text,
          )
              ? () {
                  if (isEdit && id != null) {
                    ref.read(colorPaletteManagerProvider).update(
                          id: id!,
                          palette: colorPaletteState.value,
                          label: paletteNameController.text,
                          order: 0,
                        );
                  } else {
                    ref.read(colorPaletteManagerProvider).add(
                          palette: colorPaletteState.value,
                          label: paletteNameController.text,
                          order: 0,
                        );
                  }
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('保存'),
        ),
      ],
    );
  }

  bool _isValid(
    List<Color> colorPalette,
    String paletteName,
  ) {
    if (colorPalette.isEmpty) {
      return false;
    }
    if (paletteName.isEmpty) {
      return false;
    }
    return true;
  }
}
