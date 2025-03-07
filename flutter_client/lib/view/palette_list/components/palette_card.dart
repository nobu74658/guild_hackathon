import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/app/manager/color_palette_manager.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:knitting/view/palette_list/components/select_color_dialog.dart';

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

class PaletteCard extends ConsumerWidget {
  const PaletteCard({super.key, required this.palette});

  final ColorPalette palette;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _Card(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => SelectColorDialog(
              id: palette.id,
              paletteName: palette.label,
              colorPalette: palette.paletteColors,
              isEdit: true,
            ),
          );
        },
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
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('削除しますか？'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('キャンセル'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(colorPaletteManagerProvider)
                                    .delete(palette.id);
                                Navigator.pop(context);
                              },
                              child: const Text('削除'),
                            ),
                          ],
                        ),
                      );
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
  const AddPaletteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (context) => const SelectColorDialog(
            id: null,
            paletteName: '',
            colorPalette: [],
            isEdit: false,
          ),
        ),
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
}
