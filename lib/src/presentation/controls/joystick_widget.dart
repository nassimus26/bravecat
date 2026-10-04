import 'package:flutter/material.dart';

class JoystickWidget extends StatefulWidget {
  final Function(Offset) onDirectionChanged;

  const JoystickWidget({super.key, required this.onDirectionChanged});

  @override
  State<JoystickWidget> createState() => _JoystickWidgetState();
}

class _JoystickWidgetState extends State<JoystickWidget> {
  Offset _dragPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          double dx = (_dragPosition.dx + details.delta.dx).clamp(-40.0, 40.0);
          double dy = (_dragPosition.dy + details.delta.dy).clamp(-40.0, 40.0);
          _dragPosition = Offset(dx, dy);
        });
        widget.onDirectionChanged(_dragPosition * 0.1);
      },
      onPanEnd: (_) {
        setState(() {
          _dragPosition = Offset.zero;
        });
        widget.onDirectionChanged(Offset.zero);
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white30, width: 2),
        ),
        child: Center(
          child: Transform.translate(
            offset: _dragPosition,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
