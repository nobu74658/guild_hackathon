import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    super.key,
    required this.onTap,
    required this.colorPalette,
    required this.color,
  });

  final void Function() onTap;
  final List<Color> colorPalette;
  final ValueNotifier<Color> color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ValueListenableBuilder<Color>(
        valueListenable: color,
        builder: (context, value, child) {
          return Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: value,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        },
      ),
    );
  }
}
