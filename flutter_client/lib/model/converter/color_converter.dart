import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

const colorConverterConverter = ColorConverterConverter();

class ColorConverterConverter
    implements JsonConverter<Color, Map<String, double>> {
  const ColorConverterConverter();

  @override
  Color fromJson(Map<String, double> json) {
    return Color.fromARGB(
      (json['a'] ?? 255).toInt(),
      (json['r'] ?? 0).toInt(),
      (json['g'] ?? 0).toInt(),
      (json['b'] ?? 0).toInt(),
    );
  }

  @override
  Map<String, double> toJson(Color object) {
    return {
      'a': object.a,
      'r': object.r,
      'g': object.g,
      'b': object.b,
    };
  }
}

const colorListConverter = ColorListConverter();

class ColorListConverter
    implements JsonConverter<List<Color>, List<Map<String, double>>> {
  const ColorListConverter();

  @override
  List<Color> fromJson(List<Map<String, double>> json) {
    return json.map((e) => colorConverterConverter.fromJson(e)).toList();
  }

  @override
  List<Map<String, double>> toJson(List<Color> object) {
    return object.map((e) => colorConverterConverter.toJson(e)).toList();
  }
}
