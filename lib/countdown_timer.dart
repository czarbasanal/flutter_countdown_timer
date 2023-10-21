import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerDemo extends StatefulWidget {
  const CountdownTimerDemo({super.key});

  @override
  _CountdownTimerDemoState createState() => _CountdownTimerDemoState();
}

class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 5);

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Timer Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$days days $hours:$minutes:$seconds',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startTimer,
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (countdownTimer == null || countdownTimer!.isActive) {
                  stopTimer();
                }
              },
              child: Text(
                'Stop',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  resetTimer();
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: CountdownTimerDemo()));
