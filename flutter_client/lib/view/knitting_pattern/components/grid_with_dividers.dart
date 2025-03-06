import 'package:flutter/material.dart';

class KnittingGridWithDividers extends StatelessWidget {
  const KnittingGridWithDividers({
    super.key,
    required this.totalRows,
    required this.totalColumns,
    required this.certainWidthGap,
    required this.gapRatio,
    this.cellWidth,
    this.cellHeight,
    this.specialLineFrequency = 10,
    this.regularLineColor = Colors.grey,
    this.specialLineColor = Colors.black,
    this.regularLineWidth = 0.5,
    this.specialLineWidth = 2.0,
  });
  final int totalRows;
  final int totalColumns;
  final double? cellWidth;
  final double? cellHeight;
  final int specialLineFrequency;
  final Color regularLineColor;
  final Color specialLineColor;
  final double regularLineWidth;
  final double specialLineWidth;
  final double certainWidthGap;
  final double gapRatio;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        cellWidth ?? 20.0 * totalColumns,
        cellHeight ?? 20.0 * totalRows,
      ),
      painter: _GridPainter(
        totalRows: totalRows,
        totalColumns: totalColumns,
        cellWidth: cellWidth,
        cellHeight: cellHeight,
        specialLineFrequency: specialLineFrequency,
        regularLineColor: regularLineColor,
        specialLineColor: specialLineColor,
        regularLineWidth: regularLineWidth,
        specialLineWidth: specialLineWidth,
        certainWidthGap: certainWidthGap,
        gapRatio: gapRatio,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({
    required this.totalRows,
    required this.totalColumns,
    this.cellWidth,
    this.cellHeight,
    required this.specialLineFrequency,
    required this.regularLineColor,
    required this.specialLineColor,
    required this.regularLineWidth,
    required this.specialLineWidth,
    required this.certainWidthGap,
    required this.gapRatio,
  });
  final int totalRows;
  final int totalColumns;
  final double? cellWidth;
  final double? cellHeight;
  final int specialLineFrequency;
  final Color regularLineColor;
  final Color specialLineColor;
  final double regularLineWidth;
  final double specialLineWidth;
  final double certainWidthGap;
  final double gapRatio;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint regularPaint = Paint()
      ..color = regularLineColor
      ..strokeWidth = regularLineWidth;

    final Paint specialPaint = Paint()
      ..color = specialLineColor
      ..strokeWidth = specialLineWidth;

    final double effectiveCellWidth = cellWidth ?? size.width / totalColumns;
    final double effectiveCellHeight = cellHeight ?? size.height / totalRows;

    for (int i = 0; i <= totalRows; i++) {
      final y = i * effectiveCellHeight;
      final Paint linePaint =
          i % specialLineFrequency == 0 ? specialPaint : regularPaint;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        linePaint,
      );

      for (int dx = 0; dx <= totalColumns; dx++) {
        final x = dx * effectiveCellWidth;
        final Paint linePaint =
            dx % specialLineFrequency == 0 ? specialPaint : regularPaint;

        final certainGap = -3 * certainWidthGap;
        final dxGap = gapRatio * (totalRows - i) * effectiveCellWidth;

        canvas.drawLine(
          Offset(
            x + dxGap + (i.isEven ? certainGap : 0),
            i * effectiveCellHeight,
          ),
          Offset(
            x + dxGap + (i.isEven ? certainGap : 0),
            (i + 1) * effectiveCellHeight,
          ),
          linePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
