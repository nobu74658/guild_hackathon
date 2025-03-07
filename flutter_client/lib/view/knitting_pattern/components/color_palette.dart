import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ColorPaletteBottomSheet extends StatelessWidget {
  const ColorPaletteBottomSheet({
    super.key,
    required this.onTap,
    required this.selectedColor,
    required this.paletteColors,
  }) : assert(
          paletteColors.length == 6,
          'paletteColors must have exactly 6 colors.',
        );

  final void Function(Color) onTap;
  final Color selectedColor;
  final List<Color> paletteColors;

  @override
  Widget build(BuildContext context) {
    const radius = 24.0;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final paletteColor in paletteColors.sublist(0, 3))
                _PaletteCircle(
                  radius: radius,
                  onTap: () => onTap(paletteColor),
                  color: paletteColor,
                  selectedColor: selectedColor,
                ),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final paletteColor in paletteColors.sublist(3, 6))
                _PaletteCircle(
                  radius: radius,
                  onTap: () => onTap(paletteColor),
                  color: paletteColor,
                  selectedColor: selectedColor,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaletteCircle extends StatelessWidget {
  const _PaletteCircle({
    required this.onTap,
    required this.color,
    required this.selectedColor,
    required this.radius,
  });

  final void Function() onTap;
  final Color color;
  final Color selectedColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: color == selectedColor ? Colors.blue : Colors.grey,
        child: CircleAvatar(
          radius: radius - 2,
          backgroundColor: color,
        ),
      ),
    );
  }
}
