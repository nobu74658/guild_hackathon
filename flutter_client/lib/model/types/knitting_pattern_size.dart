enum KnittingPatternSizeType {
  eight(' 8  × 8', 8, 8),
  sixteen('16 × 16', 16, 16),
  twentyFour('24 × 24', 24, 24),
  thirtyTwo('32 × 32', 32, 32);

  const KnittingPatternSizeType(this.label, this.width, this.height);

  final String label;
  final int width;
  final int height;
}
