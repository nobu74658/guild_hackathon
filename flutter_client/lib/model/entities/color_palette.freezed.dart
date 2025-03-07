// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_palette.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ColorPalette _$ColorPaletteFromJson(Map<String, dynamic> json) {
  return _ColorPalette.fromJson(json);
}

/// @nodoc
mixin _$ColorPalette {
  String get colorColorPaletteId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  @colorListConverter
  List<Color> get paletteColors => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  /// Serializes this ColorPalette to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColorPaletteCopyWith<ColorPalette> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorPaletteCopyWith<$Res> {
  factory $ColorPaletteCopyWith(
          ColorPalette value, $Res Function(ColorPalette) then) =
      _$ColorPaletteCopyWithImpl<$Res, ColorPalette>;
  @useResult
  $Res call(
      {String colorColorPaletteId,
      String label,
      @colorListConverter List<Color> paletteColors,
      int order});
}

/// @nodoc
class _$ColorPaletteCopyWithImpl<$Res, $Val extends ColorPalette>
    implements $ColorPaletteCopyWith<$Res> {
  _$ColorPaletteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colorColorPaletteId = null,
    Object? label = null,
    Object? paletteColors = null,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      colorColorPaletteId: null == colorColorPaletteId
          ? _value.colorColorPaletteId
          : colorColorPaletteId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      paletteColors: null == paletteColors
          ? _value.paletteColors
          : paletteColors // ignore: cast_nullable_to_non_nullable
              as List<Color>,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColorPaletteImplCopyWith<$Res>
    implements $ColorPaletteCopyWith<$Res> {
  factory _$$ColorPaletteImplCopyWith(
          _$ColorPaletteImpl value, $Res Function(_$ColorPaletteImpl) then) =
      __$$ColorPaletteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String colorColorPaletteId,
      String label,
      @colorListConverter List<Color> paletteColors,
      int order});
}

/// @nodoc
class __$$ColorPaletteImplCopyWithImpl<$Res>
    extends _$ColorPaletteCopyWithImpl<$Res, _$ColorPaletteImpl>
    implements _$$ColorPaletteImplCopyWith<$Res> {
  __$$ColorPaletteImplCopyWithImpl(
      _$ColorPaletteImpl _value, $Res Function(_$ColorPaletteImpl) _then)
      : super(_value, _then);

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colorColorPaletteId = null,
    Object? label = null,
    Object? paletteColors = null,
    Object? order = null,
  }) {
    return _then(_$ColorPaletteImpl(
      colorColorPaletteId: null == colorColorPaletteId
          ? _value.colorColorPaletteId
          : colorColorPaletteId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      paletteColors: null == paletteColors
          ? _value._paletteColors
          : paletteColors // ignore: cast_nullable_to_non_nullable
              as List<Color>,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColorPaletteImpl extends _ColorPalette {
  const _$ColorPaletteImpl(
      {required this.colorColorPaletteId,
      required this.label,
      @colorListConverter required final List<Color> paletteColors,
      required this.order})
      : _paletteColors = paletteColors,
        super._();

  factory _$ColorPaletteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorPaletteImplFromJson(json);

  @override
  final String colorColorPaletteId;
  @override
  final String label;
  final List<Color> _paletteColors;
  @override
  @colorListConverter
  List<Color> get paletteColors {
    if (_paletteColors is EqualUnmodifiableListView) return _paletteColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paletteColors);
  }

  @override
  final int order;

  @override
  String toString() {
    return 'ColorPalette(colorColorPaletteId: $colorColorPaletteId, label: $label, paletteColors: $paletteColors, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorPaletteImpl &&
            (identical(other.colorColorPaletteId, colorColorPaletteId) ||
                other.colorColorPaletteId == colorColorPaletteId) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality()
                .equals(other._paletteColors, _paletteColors) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, colorColorPaletteId, label,
      const DeepCollectionEquality().hash(_paletteColors), order);

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorPaletteImplCopyWith<_$ColorPaletteImpl> get copyWith =>
      __$$ColorPaletteImplCopyWithImpl<_$ColorPaletteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorPaletteImplToJson(
      this,
    );
  }
}

abstract class _ColorPalette extends ColorPalette {
  const factory _ColorPalette(
      {required final String colorColorPaletteId,
      required final String label,
      @colorListConverter required final List<Color> paletteColors,
      required final int order}) = _$ColorPaletteImpl;
  const _ColorPalette._() : super._();

  factory _ColorPalette.fromJson(Map<String, dynamic> json) =
      _$ColorPaletteImpl.fromJson;

  @override
  String get colorColorPaletteId;
  @override
  String get label;
  @override
  @colorListConverter
  List<Color> get paletteColors;
  @override
  int get order;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColorPaletteImplCopyWith<_$ColorPaletteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
