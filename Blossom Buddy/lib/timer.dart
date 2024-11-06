import 'dart:async';

import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'gradient_widget.dart';

class blossomTimer extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
  }

class _MainPageState extends State<blossomTimer>{
  static const maxSeconds = 60;
  int seconds = maxSeconds;

  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_){
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
  }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: GradientWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimer(),
            const SizedBox(height: 80),
            buildButtons(),
          ],
        )
      ),
    ),
  );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
      ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(text: isRunning ? 'Pause' : 'Resume',
          color: Colors.black,
          backgroundColor: Color(0xFFFCC9C5),
          onClicked: (){
          if (isRunning){
            stopTimer(reset: false);
          } else {
            startTimer(reset: false);
          }
        },
        ),
        const SizedBox(width: 12),

        ButtonWidget(text: 'Cancel',
          color: Colors.black,
          backgroundColor: Color(0xFFFCC9C5),
          onClicked: stopTimer,)
      ],
    )

    : ButtonWidget(
      text: 'Start Timer!',
      color: Colors.black,
      backgroundColor: Color(0xFFFCC9C5),
      onClicked: (){
        startTimer();
      },
    );
  }

  Widget buildTimer() => SizedBox(
    width: 200,
    height: 200,

    child: Stack(
    fit: StackFit.expand,
    children: [
      CircularProgressIndicator(
        value: 1 - seconds/ maxSeconds,
        strokeWidth: 12,
        color: Color(0xFFFCC9C5),
        backgroundColor: Colors.white,
      ),
      Center(child: buildTime())
      ],
    )
  );

  Widget buildTime() {
    if (seconds == 0){
      return Icon(Icons.done, color: Color(0xFFFCC9C5), size: 112);
    } else {
      return Text('$seconds',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 80,
        ),
      );
    }
  }
}