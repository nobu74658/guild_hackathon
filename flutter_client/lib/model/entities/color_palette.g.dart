// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_palette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ColorPaletteImpl _$$ColorPaletteImplFromJson(Map<String, dynamic> json) =>
    _$ColorPaletteImpl(
      colorColorPaletteId: json['colorColorPaletteId'] as String,
      label: json['label'] as String,
      paletteColors: colorListConverter
          .fromJson(json['paletteColors'] as List<Map<String, double>>),
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$$ColorPaletteImplToJson(_$ColorPaletteImpl instance) =>
    <String, dynamic>{
      'colorColorPaletteId': instance.colorColorPaletteId,
      'label': instance.label,
      'paletteColors': colorListConverter.toJson(instance.paletteColors),
      'order': instance.order,
    };
