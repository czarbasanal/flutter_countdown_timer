import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late Timer timer;
  int start = 60; // Set to 60 seconds (1 minute)
  int maxTime = 3600; // Set to 3600 seconds (1 hour)
  var isTimerOn = false;
  bool isPaused = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else if (!isPaused) {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void stopTimer() {
    timer.cancel();
    setState(() {
      isTimerOn = false;
      isPaused = false;
      start = 60; // Reset to 1 minute
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int hours = start ~/ 3600;
    int minutes = (start % 3600) ~/ 60;
    int seconds = start % 60;

    String timeDisplay =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    Color sliderColor = start <= 5 ? Colors.red : const Color(0xfff24FFCC);

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text(
          'Timer',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: const Color(0xfff2B2B2B),
      ),
      body: Container(
        color: const Color(0xfff2B2B2B),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.width * 0.85,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  size: MediaQuery.of(context).size.width * 0.84,
                  customColors: CustomSliderColors(
                    trackColor: const Color(0xfff364643),
                    progressBarColor: sliderColor,
                    dotColor: Colors.black,
                    shadowColor: Colors.grey.shade600,
                  ),
                  startAngle: 270,
                  angleRange: 360,
                  customWidths: CustomSliderWidths(
                    trackWidth: 36,
                    progressBarWidth: 22,
                    handlerSize: 7,
                  ),
                ),
                min: 0,
                max: maxTime.toDouble(),
                initialValue: start.toDouble(),
                onChange: (double value) {
                  setState(() {
                    start = value.round();
                  });
                },
                innerWidget: (percentage) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timeDisplay,
                        style: TextStyle(
                          fontSize: 56,
                          color: sliderColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "hr           min           sec",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                if (isTimerOn) {
                  if (isPaused) {
                    togglePause();
                  } else {
                    togglePause();
                  }
                } else {
                  isTimerOn = true;
                  startTimer();
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width * 0.65),
                  backgroundColor: isTimerOn
                      ? isPaused
                          ? Color(0xfff24FFCC)
                          : Colors.amber
                      : Color(0xfff24FFCC),
                  shadowColor: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(vertical: 12.0)),
              child: Text(
                isTimerOn
                    ? isPaused
                        ? 'Resume'
                        : 'Pause'
                    : 'Start',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: stopTimer,
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size.fromWidth(MediaQuery.of(context).size.width * 0.65),
                backgroundColor: Colors.red,
                shadowColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              child: const Text(
                'Stop',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
