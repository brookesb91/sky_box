import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'package:sky_box/widgets/sky_box_painter.dart';

class SkyBox extends StatefulWidget {
  /// The top image of the sky box.
  /// Positive Y axis.
  final ui.Image top;

  /// The front image of the sky box.
  /// Positive Z axis.
  final ui.Image front;

  /// The right image of the sky box.
  /// Positive X axis.
  final ui.Image right;

  /// The back image of the sky box.
  /// Negative Z axis.
  final ui.Image back;

  /// The left image of the sky box.
  /// Negative X axis.
  final ui.Image left;

  /// The bottom image of the sky box.
  /// Negative Y axis.
  final ui.Image bottom;

  /// The field of view of the sky box.
  /// The default value is 60.
  final double fov;

  /// The perspective of the sky box.
  /// The default value is 0.3.
  final double perspective;

  /// The sensitivity of the sky box panning.
  /// The default value is 0.1.
  final double sensitivity;

  /// The child widget.
  /// This widget will be drawn on top of the sky box.
  /// The default value is null.
  final Widget? child;

  const SkyBox({
    super.key,
    required this.top,
    required this.front,
    required this.right,
    required this.back,
    required this.left,
    required this.bottom,
    this.fov = 60,
    this.perspective = 0.3,
    this.sensitivity = 0.1,
    this.child,
  });

  @override
  State<SkyBox> createState() => _SkyBoxState();
}

class _SkyBoxState extends State<SkyBox> {
  double _pitch = 0;
  double _yaw = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _pitch = (_pitch + details.delta.dy * widget.sensitivity) % 360;
          _yaw = (_yaw + details.delta.dx * widget.sensitivity) % 360;
        });
      },
      child: CustomPaint(
        painter: SkyBoxPainter(
          top: widget.top,
          front: widget.front,
          right: widget.right,
          back: widget.back,
          left: widget.left,
          bottom: widget.bottom,
          pitch: _pitch,
          yaw: _yaw,
          fov: widget.fov,
          perspective: widget.perspective,
        ),
        child: widget.child,
      ),
    );
  }
}
