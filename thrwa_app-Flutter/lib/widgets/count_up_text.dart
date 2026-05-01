import 'package:flutter/material.dart';

class CountUpText extends StatelessWidget {
  final double value;
  final TextStyle style;
  final String prefix;
  final String suffix;
  final int decimalPlaces;
  final Duration duration;

  const CountUpText({
    super.key,
    required this.value,
    required this.style,
    this.prefix = '',
    this.suffix = '',
    this.decimalPlaces = 0,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutQuart,
      builder: (context, animatedValue, child) {
        String formattedValue = animatedValue
            .toStringAsFixed(decimalPlaces)
            .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            );
        return Text('$prefix$formattedValue$suffix', style: style);
      },
    );
  }
}
