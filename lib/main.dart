import 'package:flutter/material.dart';
import 'countdown_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const CountdownTimerDemo(),
    );
  }
}
