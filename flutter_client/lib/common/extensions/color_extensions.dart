import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// Converts a Color to a hex string in the format #RRGGBB
  String toHex() {
    final colorStr = value.toRadixString(16).toString();
    if (colorStr.length == 8) {
      final hexcolor = colorStr.substring(2);
      final transparent = colorStr.substring(0, 2);
    if (transparent == "ff") {
      return "#" + hexcolor;
    } else {
      return "#" + hexcolor + transparent;
    }
    } else {
      return "#" + colorStr + "00";
    }
  }
}

extension ColorListExtension on List<Color> {
  /// Converts a List<Color> to a list of hex strings in the format #RRGGBB
  List<String> toHexStrings() {
    return map((color) => color.toHex()).toList();
  }
}
