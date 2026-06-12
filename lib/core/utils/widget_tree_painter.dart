import 'package:flutter/material.dart';

class WidgetTreePainter extends CustomPainter {
  final ColorScheme colorScheme;
  WidgetTreePainter(this.colorScheme);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colorScheme.onSurface.withOpacity(0.02)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double nodeSize = 40;

    void drawNode(double x, double y) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(x, y),
            width: nodeSize,
            height: nodeSize,
          ),
          const Radius.circular(8),
        ),
        paint,
      );
    }

    void drawLine(Offset start, Offset end) {
      canvas.drawLine(start, end, paint);
    }

    drawNode(100, 150);
    drawNode(50, 250);
    drawNode(150, 250);
    drawLine(const Offset(100, 170), const Offset(50, 230));
    drawLine(const Offset(100, 170), const Offset(150, 230));

    final w = size.width;
    final h = size.height;
    if (w > 400 && h > 400) {
      drawNode(w - 150, h - 300);
      drawNode(w - 200, h - 200);
      drawNode(w - 100, h - 200);
      drawNode(w - 250, h - 100);
      drawLine(Offset(w - 150, h - 280), Offset(w - 200, h - 220));
      drawLine(Offset(w - 150, h - 280), Offset(w - 100, h - 220));
      drawLine(Offset(w - 200, h - 180), Offset(w - 250, h - 120));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
