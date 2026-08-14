import 'package:flutter/material.dart';

/// The viewfinder the design lays over anything the app is "identifying":
/// four rounded corner brackets with a soft sweep filling the lower half.
///
/// It is drawn rather than exported because the design stretches the same
/// mark to a different aspect on every screen — tall over the welcome plant,
/// wide over the phone's camera preview — and a bitmap cannot follow that
/// without distorting its own stroke weight.
class ScanFrame extends StatelessWidget {
  const ScanFrame({
    this.color = Colors.white,
    this.strokeWidth = 3.5,
    super.key,
  });

  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        painter: _ScanFramePainter(color: color, strokeWidth: strokeWidth),
        size: Size.infinite,
      ),
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  const _ScanFramePainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final double inset = strokeWidth / 2;
    final double left = inset;
    final double top = inset;
    final double right = size.width - inset;
    final double bottom = size.height - inset;

    final double shortest = size.shortestSide;
    final double radius = shortest * _radiusFactor;
    final double arm = shortest * _armFactor;

    // The sweep: crisp along its top edge, fading out before the lower
    // brackets, exactly as the export has it.
    canvas.drawRect(
      Rect.fromLTRB(left, size.height * _sweepTop, right, bottom),
      Paint()
        ..shader =
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                color.withValues(alpha: _sweepOpacity),
                color.withValues(alpha: 0),
              ],
            ).createShader(
              Rect.fromLTRB(left, size.height * _sweepTop, right, bottom),
            ),
    );

    final Paint bracket = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas
      ..drawPath(
        Path()
          ..moveTo(left, top + radius + arm)
          ..lineTo(left, top + radius)
          ..arcToPoint(
            Offset(left + radius, top),
            radius: Radius.circular(radius),
          )
          ..lineTo(left + radius + arm, top),
        bracket,
      )
      ..drawPath(
        Path()
          ..moveTo(right - radius - arm, top)
          ..lineTo(right - radius, top)
          ..arcToPoint(
            Offset(right, top + radius),
            radius: Radius.circular(radius),
          )
          ..lineTo(right, top + radius + arm),
        bracket,
      )
      ..drawPath(
        Path()
          ..moveTo(right, bottom - radius - arm)
          ..lineTo(right, bottom - radius)
          ..arcToPoint(
            Offset(right - radius, bottom),
            radius: Radius.circular(radius),
          )
          ..lineTo(right - radius - arm, bottom),
        bracket,
      )
      ..drawPath(
        Path()
          ..moveTo(left + radius + arm, bottom)
          ..lineTo(left + radius, bottom)
          ..arcToPoint(
            Offset(left, bottom - radius),
            radius: Radius.circular(radius),
          )
          ..lineTo(left, bottom - radius - arm),
        bracket,
      );
  }

  @override
  bool shouldRepaint(_ScanFramePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;

  /// Corner radius and arm length as fractions of the frame's shorter side.
  static const double _radiusFactor = 0.16;
  static const double _armFactor = 0.10;

  /// Where the sweep starts, down the frame, and how opaque it begins.
  static const double _sweepTop = 0.46;
  static const double _sweepOpacity = 0.55;
}
