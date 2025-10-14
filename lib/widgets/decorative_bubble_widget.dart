import 'package:flutter/material.dart';

enum BubbleDirection {
  left,
  right,
}

enum TrianglePosition {
  top,
  bottom,
}

class DecorativeBubbleWidget extends StatelessWidget {
  final Widget child;
  final BubbleDirection direction;
  final TrianglePosition trianglePosition;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double triangleSize;

  const DecorativeBubbleWidget({
    super.key,
    required this.child,
    this.direction = BubbleDirection.right,
    this.trianglePosition = TrianglePosition.bottom,
    this.backgroundColor = Colors.white,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(12.0),
    this.triangleSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    final triangle = Padding(
      padding: EdgeInsets.only(
        left: direction == BubbleDirection.right ? triangleSize : 0,
        right: direction == BubbleDirection.left ? triangleSize : 0,
      ),
      child: CustomPaint(
        painter: TrianglePainter(
          color: backgroundColor,
          direction: direction,
          position: trianglePosition,
        ),
        size: Size(triangleSize * 4, triangleSize * 2),
      ),
    );

    final container = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: direction == BubbleDirection.right
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: trianglePosition == TrianglePosition.top
          ? [triangle, container]
          : [container, triangle],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final BubbleDirection direction;
  final TrianglePosition position;

  TrianglePainter({
    required this.color,
    required this.direction,
    required this.position,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (position == TrianglePosition.bottom) {
      // Segitiga di bawah bubble
      if (direction == BubbleDirection.right) {
        // Segitiga mengarah ke bawah-kanan dengan posisi lebih ke tengah
        path.moveTo(size.width * 0.2, 0); // Titik kiri atas base
        path.lineTo(size.width * 0.8, 0); // Titik kanan atas base
        path.lineTo(size.width * 0.7, size.height); // Titik ujung bawah
        path.close();
      } else {
        // Segitiga mengarah ke bawah-kiri dengan posisi lebih ke tengah
        path.moveTo(size.width * 0.2, 0); // Titik kiri atas base
        path.lineTo(size.width * 0.8, 0); // Titik kanan atas base
        path.lineTo(size.width * 0.3, size.height); // Titik ujung bawah
        path.close();
      }
    } else {
      // Segitiga di atas bubble
      if (direction == BubbleDirection.right) {
        // Segitiga mengarah ke atas-kanan dengan posisi lebih ke tengah
        path.moveTo(size.width * 0.7, 0); // Titik ujung atas
        path.lineTo(size.width * 0.2, size.height); // Titik kiri bawah base
        path.lineTo(size.width * 0.8, size.height); // Titik kanan bawah base
        path.close();
      } else {
        // Segitiga mengarah ke atas-kiri dengan posisi lebih ke tengah
        path.moveTo(size.width * 0.3, 0); // Titik ujung atas
        path.lineTo(size.width * 0.2, size.height); // Titik kiri bawah base
        path.lineTo(size.width * 0.8, size.height); // Titik kanan bawah base
        path.close();
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
