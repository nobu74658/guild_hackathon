class KnittingPatternSizeType {
  const KnittingPatternSizeType._(this.width, this.height);

  static const List<KnittingPatternSizeType> values = [
    KnittingPatternSizeType._(15, 15),
    KnittingPatternSizeType._(20, 20),
    KnittingPatternSizeType._(25, 25),
    KnittingPatternSizeType._(30, 30),
    KnittingPatternSizeType._(40, 40),
    KnittingPatternSizeType._(60, 60),
    KnittingPatternSizeType._(90, 90),
  ];

  final int width;
  final int height;
}
