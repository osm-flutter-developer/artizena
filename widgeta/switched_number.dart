
import 'package:flutter/material.dart';


class SwitchedNumber extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final bool isIncrement;
  final Axis direction;
  const SwitchedNumber({super.key,
    required this.duration,
    required this.child,
    required this.isIncrement,
    this.direction = Axis.vertical,
  });

  @override
  State<SwitchedNumber> createState() => _SwitchedNumberState();
}

class _SwitchedNumberState extends State<SwitchedNumber> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Widget? _oldChild;
  Widget? _currentChild;

  @override
  void initState() {
    super.initState();
    _currentChild = widget.child;
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant SwitchedNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.child.key != oldWidget.child.key) {
      _oldChild = _currentChild;
      _currentChild = widget.child;

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            if(_oldChild != null && _animationController.value < 0.50) SlideTransition(
              position: widget.isIncrement
                  ? Tween<Offset>(begin: Offset(0.0, 0.0), end: widget.direction == Axis.horizontal ? Offset(-0.70, 0.0) : Offset(0.0, -0.70)).animate(_animationController)
                  : Tween<Offset>(begin: Offset(0.0, 0.0), end: widget.direction == Axis.horizontal ? Offset( 0.70, 0.0) : Offset(0.0, 0.70)).animate(_animationController),
              child: FadeTransition(
                opacity: Tween<double>(begin: 1.0, end: 0.30).animate(_animationController),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 0.30).animate(_animationController),
                  child: _oldChild,
                ),
              ),
            ),
            if(_currentChild != null) SlideTransition(
              position: widget.isIncrement
                  ? Tween<Offset>(begin: widget.direction == Axis.horizontal ? Offset( 0.70, 0.0) : Offset(0.0, 0.70), end: Offset(0.0, 0.0)).animate(_animationController)
                  : Tween<Offset>(begin: widget.direction == Axis.horizontal ? Offset(-0.70, 0.0) : Offset(0.0, -0.70), end: Offset(0.0, 0.0)).animate(_animationController),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.20, end: 1.0).animate(_animationController),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.20, end: 1.0).animate(_animationController),
                  child: _currentChild,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}

