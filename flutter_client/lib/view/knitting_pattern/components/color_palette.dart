import 'package:flutter/material.dart';

class ColorPaletteBottomSheet extends StatelessWidget {
  const ColorPaletteBottomSheet({
    super.key,
    required this.onTap,
    required this.selectedColor,
    required this.paletteColors,
  });

  final void Function(Color) onTap;
  final Color selectedColor;
  final List<Color> paletteColors;

  @override
  Widget build(BuildContext context) {
    const radius = 24.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      color: Colors.white,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Adjust the number of columns as needed
        ),
        itemCount: paletteColors.length,
        itemBuilder: (context, index) {
          final paletteColor = paletteColors[index];
          return Align(
            child: _PaletteCircle(
              radius: radius,
              onTap: () => onTap(paletteColor),
              color: paletteColor,
              selectedColor: selectedColor,
            ),
          );
        },
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
