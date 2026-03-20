import 'dart:math' as math;

import 'package:flutter/material.dart';

/// System design hub-and-spoke logo.
///
/// Centre: filled circle (hub / load balancer).
/// Corners: hollow rounded-rect nodes (services).
/// Edges: rounded lines connecting hub to each service.
class AppLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLogo({super.key, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return CustomPaint(
      size: Size(size, size),
      painter: _LogoPainter(color: c),
    );
  }
}

class _LogoPainter extends CustomPainter {
  final Color color;
  _LogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;

    // ── geometry ──────────────────────────────────────────────
    final center = Offset(w * 0.5, w * 0.5);

    // Four service nodes at the cardinal diagonal positions
    final nodes = [
      Offset(w * 0.16, w * 0.16), // top-left
      Offset(w * 0.84, w * 0.16), // top-right
      Offset(w * 0.84, w * 0.84), // bottom-right
      Offset(w * 0.16, w * 0.84), // bottom-left
    ];

    final hubRadius    = w * 0.145;
    final nodeHalf     = w * 0.110; // half-side of service square
    final nodeCorner   = w * 0.040;
    final stroke       = w * 0.072;

    // ── paints ────────────────────────────────────────────────
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final hubFill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final nodePaint = Paint()
      ..color = color
      ..strokeWidth = stroke * 0.75
      ..style = PaintingStyle.stroke;

    // ── edges (lines from hub to each node, with gaps) ────────
    for (final node in nodes) {
      final delta = node - center;
      final dist  = delta.distance;
      final unit  = delta / dist;

      // Gap at hub side: hubRadius + half stroke
      // Gap at node side: diagonal half-width of the square ≈ nodeHalf * √2
      final gapHub  = hubRadius + stroke * 0.5;
      final gapNode = nodeHalf * math.sqrt2 * 0.65 + stroke * 0.4;

      final p1 = center + unit * gapHub;
      final p2 = node   - unit * gapNode;

      if ((p2 - p1).distance > 0) canvas.drawLine(p1, p2, linePaint);
    }

    // ── service nodes (rounded squares) ───────────────────────
    for (final node in nodes) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: node,
          width:  nodeHalf * 2,
          height: nodeHalf * 2,
        ),
        Radius.circular(nodeCorner),
      );
      canvas.drawRRect(rect, nodePaint);
    }

    // ── hub (filled circle) ───────────────────────────────────
    canvas.drawCircle(center, hubRadius, hubFill);
  }

  @override
  bool shouldRepaint(_LogoPainter old) => old.color != color;
}
