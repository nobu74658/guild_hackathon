import 'package:flutter/material.dart';
import 'package:knitting/model/knitting_type.dart';

class KnittingPatternSelector extends StatelessWidget {
  const KnittingPatternSelector({
    super.key,
    required this.onTap,
    required this.selectedKnittingType,
  });

  final void Function(KnittingType) onTap;
  final KnittingType selectedKnittingType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final knittingPattern in KnittingType.values)
            ListTile(
              title: Text(
                knittingPattern.name,
                style: TextStyle(
                  color: knittingPattern == selectedKnittingType
                      ? Colors.black
                      : Colors.grey[800],
                  fontWeight: knittingPattern == selectedKnittingType
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              // TODO: 編み地の画像を表示
              onTap: () => onTap(knittingPattern),
            ),
        ],
      ),
    );
  }
}
