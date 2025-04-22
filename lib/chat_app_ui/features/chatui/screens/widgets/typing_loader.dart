import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TypingLoader extends StatefulWidget {
  const TypingLoader({super.key});

  @override
  State<TypingLoader> createState() => _TypingLoaderState();
}

class _TypingLoaderState extends State<TypingLoader> {
  late Timer _timer;
  double _secondsElapsed = 0.0;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _secondsElapsed += 0.3;
        _dotCount = (_dotCount + 1) % 4; // 0 to 3 dots
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get thinkingText => 'Thinking${'.' * _dotCount}';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/images/animations/type_loading.json',
          width: 60,
          height: 60,
          repeat: true,
        ),
        const SizedBox(width: 8),
        Text(
          '$thinkingText ${_secondsElapsed.toStringAsFixed(1)}s',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
