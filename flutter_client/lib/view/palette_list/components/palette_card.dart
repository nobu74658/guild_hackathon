import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:knitting/model/types/color_palette_type.dart';

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }
}

class PaletteCard extends StatelessWidget {
  const PaletteCard({super.key, required this.context, required this.palette});

  final BuildContext context;
  final ColorPaletteType palette;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    palette.label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // Show palette options
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: palette.paletteColors.length,
                itemBuilder: (context, idx) {
                  final color = palette.paletteColors[idx];
                  return Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(64),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPaletteCard extends StatelessWidget {
  const AddPaletteCard({super.key, required this.context, required this.color});

  final BuildContext context;
  final ValueNotifier<Color> color;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: InkWell(
        onTap: () => showAddPaletteDialog(context, color),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                CupertinoIcons.add_circled,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 8),
              Text(
                '新しいパレットを作成',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddPaletteDialog(BuildContext context, ValueNotifier<Color> color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '新しいパレットを作成',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'パレット名',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ColorPicker(
                  paletteType: PaletteType.hueWheel,
                  pickerColor: color.value,
                  onColorChanged: (newColor) {},
                  enableAlpha: false,
                  labelTypes: const [],
                  displayThumbColor: true,
                  pickerAreaHeightPercent: 0.8,
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
              style: ElevatedButton.styleFrom(
                backgroundColor: color.value,
                foregroundColor: useWhiteForeground(color.value)
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () {
                print(color.value);
                Navigator.of(context).pop();
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  }
}
