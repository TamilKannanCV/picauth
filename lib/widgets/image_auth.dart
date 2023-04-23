import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final ui.Image image;
  final List<Offset> points;

  MyPainter({required this.image, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the image
    final src =
        Offset.zero & Size(image.width.toDouble(), image.height.toDouble());
    final dst = Offset.zero & size;
    canvas.drawImageRect(image, src, dst, Paint());

    // Draw the points
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 50
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(ui.PointMode.points, [...points], paint);
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) => true;
}

class ImageAuth extends StatefulWidget {
  final ui.Image image;

  const ImageAuth(
      {Key? key,
      required this.image,
      this.onRegionsSelected,
      this.autoHide = false})
      : super(key: key);

  final void Function(List<Offset> points)? onRegionsSelected;
  final bool autoHide;

  @override
  _ImageAuthState createState() => _ImageAuthState();
}

class _ImageAuthState extends State<ImageAuth> {
  final points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        if (points.length < 3) {
          setState(() => points.add(details.localPosition));
          if (points.length == 3) {
            widget.onRegionsSelected?.call(points);
            if (widget.autoHide) {
              setState(() {
                points.clear();
              });
            }
          }
        }
      },
      child: CustomPaint(
        painter: MyPainter(image: widget.image, points: points),
        size: const Size(double.infinity, double.infinity),
      ),
    );
  }
}
