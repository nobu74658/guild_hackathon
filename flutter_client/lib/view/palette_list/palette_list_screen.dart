import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:knitting/app/state/color_palettes_state.dart';
import 'package:knitting/common/color.dart';
import 'package:knitting/model/entities/color_palette.dart';
import 'package:knitting/view/palette_list/components/palette_card.dart';

class ConnectedPaletteListScreen extends ConsumerWidget {
  const ConnectedPaletteListScreen({super.key});

  static const path = '/palette';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paletteList = ref.watch(colorPalettesStateProvider);
    return PaletteListScreen(
      paletteList: paletteList,
    );
  }
}

class PaletteListScreen extends HookWidget {
  const PaletteListScreen({super.key, required this.paletteList});

  final List<ColorPalette> paletteList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: const Text(
          'カラーパレット',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          itemCount: paletteList.length + 1,
          separatorBuilder: (context, index) => const Gap(16),
          itemBuilder: (context, index) {
            if (index == 0) {
              return const AddPaletteCard();
            }
            return PaletteCard(
              palette: paletteList[index - 1],
            );
          },
        ),
      ),
    );
  }
}
