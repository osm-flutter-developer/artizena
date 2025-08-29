
import 'package:flutter/material.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/widgets/switched_number.dart';
import 'package:provider/provider.dart';


class AnimatedNumber extends StatefulWidget {
  final int counter;
  final TextStyle? style;
  final Duration duration;
  const AnimatedNumber({super.key,
    required this.counter,
    this.style,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<AnimatedNumber> createState() => _AnimatedNumberState();
}

class _AnimatedNumberState extends State<AnimatedNumber> {
  int oldCounter = 0;
  int newCounter = 0;

  @override
  void didUpdateWidget(covariant AnimatedNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.counter != oldWidget.counter) {
      oldCounter = newCounter;
      newCounter = widget.counter;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      oldCounter = widget.counter;
      newCounter = widget.counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppDataProvider>();
    final newDigitsString = newCounter.toString();
    final newDigits = newDigitsString.padLeft('$newCounter'.length < '$oldCounter'.length ? '$oldCounter'.length : '$newCounter'.length).split('');
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(newDigits.length, (index) {
        final newDigit = newDigits[index];
        return SwitchedNumber(
          isIncrement: newCounter > oldCounter,
          duration: widget.duration,
          child: Text(
            provider.localization.formatValue(newDigit),
            textDirection: TextDirection.ltr,
            key: ValueKey<String>(provider.localization.formatValue(newDigit)),
            style: widget.style,
          ),
        );
      }),
    );
  }
}
