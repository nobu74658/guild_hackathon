class KnittingPatternSizeType {
  const KnittingPatternSizeType._(this.width, this.height);

  static const List<KnittingPatternSizeType> values = [
    KnittingPatternSizeType._(16, 16),
    KnittingPatternSizeType._(24, 24),
    KnittingPatternSizeType._(32, 32),
    KnittingPatternSizeType._(48, 48),
    KnittingPatternSizeType._(64, 64),
    KnittingPatternSizeType._(96, 96),
  ];

  final int width;
  final int height;
}
