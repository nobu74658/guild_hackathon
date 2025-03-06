// ignore_for_file: deprecated_member_use

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
    this.numberColor = Colors.black,
    this.numberFontSize = 12.0,
    this.numberPadding = 2.0,
    this.highlightedRow,
    this.highlightedColumn,
    this.highlightColor = Colors.blue,
    this.showLeftNumbers = true,
    this.showRightNumbers = true,
    this.showTopNumbers = true,
    this.showBottomNumbers = true,
    this.specialNumberFrequency = 5,
    this.regularNumberColor,
    this.specialNumberColor,
    this.specialNumberFontSize,
    this.numberBackgroundOpacity = 0.8,
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
  final Color numberColor;
  final double numberFontSize;
  final double numberPadding;
  final int? highlightedRow;
  final int? highlightedColumn;
  final Color highlightColor;
  final bool showLeftNumbers;
  final bool showRightNumbers;
  final bool showTopNumbers;
  final bool showBottomNumbers;
  final int specialNumberFrequency;
  final Color? regularNumberColor;
  final Color? specialNumberColor;
  final double? specialNumberFontSize;
  final double numberBackgroundOpacity;

  @override
  Widget build(BuildContext context) {
    final effectiveRegularNumberColor = regularNumberColor ?? numberColor;
    final effectiveSpecialNumberColor = specialNumberColor ?? Colors.red;
    final effectiveSpecialNumberFontSize =
        specialNumberFontSize ?? (numberFontSize * 1.2);

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
        numberColor: numberColor,
        numberFontSize: numberFontSize,
        numberPadding: numberPadding,
        highlightedRow: highlightedRow,
        highlightedColumn: highlightedColumn,
        highlightColor: highlightColor,
        showLeftNumbers: showLeftNumbers,
        showRightNumbers: showRightNumbers,
        showTopNumbers: showTopNumbers,
        showBottomNumbers: showBottomNumbers,
        specialNumberFrequency: specialNumberFrequency,
        regularNumberColor: effectiveRegularNumberColor,
        specialNumberColor: effectiveSpecialNumberColor,
        specialNumberFontSize: effectiveSpecialNumberFontSize,
        numberBackgroundOpacity: numberBackgroundOpacity,
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
    required this.numberColor,
    required this.numberFontSize,
    required this.numberPadding,
    this.highlightedRow,
    this.highlightedColumn,
    required this.highlightColor,
    required this.showLeftNumbers,
    required this.showRightNumbers,
    required this.showTopNumbers,
    required this.showBottomNumbers,
    required this.specialNumberFrequency,
    required this.regularNumberColor,
    required this.specialNumberColor,
    required this.specialNumberFontSize,
    required this.numberBackgroundOpacity,
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
  final Color numberColor;
  final double numberFontSize;
  final double numberPadding;
  final int? highlightedRow;
  final int? highlightedColumn;
  final Color highlightColor;
  final bool showLeftNumbers;
  final bool showRightNumbers;
  final bool showTopNumbers;
  final bool showBottomNumbers;
  final int specialNumberFrequency;
  final Color regularNumberColor;
  final Color specialNumberColor;
  final double specialNumberFontSize;
  final double numberBackgroundOpacity;

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

    // Draw highlight for the selected row
    if (highlightedRow != null && highlightedRow! < totalRows) {
      final Paint highlightPaint = Paint()
        ..color = highlightColor
        ..style = PaintingStyle.fill;

      final y = highlightedRow! * effectiveCellHeight;
      canvas.drawRect(
        Rect.fromLTWH(0, y, size.width, effectiveCellHeight),
        highlightPaint,
      );
    }

    // Draw highlight for the selected column
    if (highlightedColumn != null && highlightedColumn! < totalColumns) {
      final Paint highlightPaint = Paint()
        ..color = highlightColor
        ..style = PaintingStyle.fill;

      final x = highlightedColumn! * effectiveCellWidth;
      canvas.drawRect(
        Rect.fromLTWH(x, 0, effectiveCellWidth, size.height),
        highlightPaint,
      );
    }

    // Draw grid lines
    for (int i = 0; i <= totalRows; i++) {
      final y = i * effectiveCellHeight;
      final Paint linePaint =
          i % specialLineFrequency == 0 ? specialPaint : regularPaint;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        linePaint,
      );

      // Draw row numbers on the left side
      if (showLeftNumbers && i < totalRows) {
        final bool isSpecial = i % specialNumberFrequency == 0;
        _drawText(
          canvas: canvas,
          text: (totalRows - i).toString(),
          position: Offset(-numberPadding - 15, y + effectiveCellHeight / 2),
          fontSize: isSpecial ? specialNumberFontSize : numberFontSize,
          color: isSpecial ? specialNumberColor : regularNumberColor,
          alignment: TextAlign.right,
          withBackground: true,
          backgroundColor: const Color.fromARGB(255, 56, 56, 56)
              .withOpacity(numberBackgroundOpacity),
          isSpecial: isSpecial,
        );
      }

      // Draw row numbers on the right side
      if (showRightNumbers && i < totalRows) {
        final bool isSpecial = i % specialNumberFrequency == 0;
        _drawText(
          canvas: canvas,
          text: (totalRows - i).toString(),
          position: Offset(
            size.width + numberPadding + 15,
            y + effectiveCellHeight / 2,
          ),
          fontSize: isSpecial ? specialNumberFontSize : numberFontSize,
          color: isSpecial ? specialNumberColor : regularNumberColor,
          withBackground: true,
          backgroundColor: Colors.white.withOpacity(numberBackgroundOpacity),
          isSpecial: isSpecial,
        );
      }

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
            (i == totalRows ? i : (i + 1)) * effectiveCellHeight,
          ),
          linePaint,
        );
      }
    }

    // Draw column numbers on the top
    if (showTopNumbers) {
      for (int j = 0; j < totalColumns; j++) {
        final bool isSpecial = j % specialNumberFrequency == 0;
        final x = j * effectiveCellWidth +
            effectiveCellWidth / 2 +
            gapRatio * (totalRows - 1) * effectiveCellWidth;
        _drawText(
          canvas: canvas,
          text: (totalColumns - j).toString(),
          position: Offset(x, -numberPadding - 15),
          fontSize: isSpecial ? specialNumberFontSize : numberFontSize,
          color: isSpecial ? specialNumberColor : regularNumberColor,
          alignment: TextAlign.center,
          withBackground: true,
          backgroundColor: Colors.white.withOpacity(numberBackgroundOpacity),
          isSpecial: isSpecial,
        );
      }
    }

    // Draw column numbers on the bottom
    if (showBottomNumbers) {
      for (int j = 0; j < totalColumns; j++) {
        final bool isSpecial = j % specialNumberFrequency == 0;
        final x = j * effectiveCellWidth + effectiveCellWidth / 2;
        _drawText(
          canvas: canvas,
          text: (totalColumns - j).toString(),
          position: Offset(x, size.height + numberPadding + 15),
          fontSize: isSpecial ? specialNumberFontSize : numberFontSize,
          color: isSpecial ? specialNumberColor : regularNumberColor,
          alignment: TextAlign.center,
          withBackground: true,
          backgroundColor: Colors.white.withOpacity(numberBackgroundOpacity),
          isSpecial: isSpecial,
        );
      }
    }
  }

  void _drawText({
    required Canvas canvas,
    required String text,
    required Offset position,
    required double fontSize,
    required Color color,
    TextAlign alignment = TextAlign.left,
    bool withBackground = false,
    Color backgroundColor = Colors.white,
    bool isSpecial = false,
  }) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: isSpecial ? FontWeight.bold : FontWeight.normal,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: alignment,
    );

    textPainter.layout();

    double dx = position.dx;
    if (alignment == TextAlign.center) {
      dx -= textPainter.width / 2;
    } else if (alignment == TextAlign.right) {
      dx -= textPainter.width;
    }

    final offset = Offset(dx, position.dy - textPainter.height / 2);

    // Add background if requested
    if (withBackground) {
      final padding = isSpecial ? 4.0 : 2.0;
      final bgRect = Rect.fromLTWH(
        offset.dx - padding,
        offset.dy - padding,
        textPainter.width + (padding * 2),
        textPainter.height + (padding * 2),
      );

      final bgPaint = Paint()..color = backgroundColor;

      // Draw rounded rectangle for special numbers
      if (isSpecial) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(bgRect, const Radius.circular(4.0)),
          bgPaint,
        );

        // Add subtle border
        final borderPaint = Paint()
          ..color = color.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        canvas.drawRRect(
          RRect.fromRectAndRadius(bgRect, const Radius.circular(4.0)),
          borderPaint,
        );
      } else {
        canvas.drawRect(bgRect, bgPaint);
      }
    }

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.totalRows != totalRows ||
        oldDelegate.totalColumns != totalColumns ||
        oldDelegate.cellWidth != cellWidth ||
        oldDelegate.cellHeight != cellHeight ||
        oldDelegate.highlightedRow != highlightedRow ||
        oldDelegate.highlightedColumn != highlightedColumn;
  }
}
