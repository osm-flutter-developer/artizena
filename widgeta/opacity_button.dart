
import 'package:flutter/material.dart';



class OpacityButton extends StatefulWidget {
  final Widget child;
  final void Function()? onPressed;
  final Duration duration;
  const OpacityButton({super.key,
    required this.child,
    required this.onPressed,
    this.duration = const Duration(milliseconds: 50),
  });

  @override
  State<OpacityButton> createState() => _OpacityButtonState();

}

class _OpacityButtonState extends State<OpacityButton> {
  bool _isPressing = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.onPressed,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _isPressing ? 0.50 : 1.0,
        child: widget.child,
      ),
      onHighlightChanged: (value) {
        setState(() => _isPressing = value);
      },
    );
  }
}
