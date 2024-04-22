import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/utils.dart';
import 'globals.dart' as globals;

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  _BreathingScreenState createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with TickerProviderStateMixin {
  var _breathe = 1.0;
  String action = "Start";
  String runningAction = "";
  String todo = "";
  late AnimationController _breathingController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
        vsync: this,
        value: _breathe,
        duration: const Duration(milliseconds: 4000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("Completed: ${_breathingController.value}, $runningAction");
        if (runningAction == 'Stop') return;
        setState(() {
          todo = "Hold";
        });
        // Hold the animation for 4 seconds
        timer = Timer(const Duration(seconds: 4), () {
          setState(() {
            todo = "Inhale";
          });
          _breathingController.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        print("Dismissed: ${_breathingController.value}, $runningAction");
        if (runningAction == 'Stop') return;
        setState(() {
          todo = "Hold";
        });
        timer = Timer(const Duration(seconds: 4), () {
          setState(() {
            todo = "Exhale";
          });
          _breathingController.forward();
        });
      }
    });

    _breathingController.addListener(() {
      setState(() {
        _breathe = _breathingController.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _breathingController.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = 200.0 - 100.0 * _breathe;
    return Scaffold(
        backgroundColor: (globals.darkTheme)
            ? globals.dark_background
            : globals.light_background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: SizedBox(
                height: 100 + size,
                width: 100 + size,
                child: Material(
                  borderRadius: BorderRadius.circular(size),
                  color: (!globals.darkTheme)
                      ? globals.dark_background
                      : globals.light_background,
                  child: Icon(
                    Icons.circle,
                    size: 200,
                    color: (globals.darkTheme)
                        ? globals.dark_background
                        : globals.light_background,
                  ),
                ),
              ),
            ),
             Center(
              child: Text(
                todo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30, // Adjust font size as needed
                ),
              ),
            ),
            Positioned(
              bottom: 30, // Adjust the distance from the bottom as needed
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (action == "Start") {
                      setState(() {
                        todo = "Inhale";
                        action = "Stop";
                        runningAction = "Start";
                      });
                      _breathingController.reverse();
                    } else {
                      setState(() {
                        action = "Start";
                        runningAction = "Stop";
                        todo = "";
                      });
                      _breathingController.reset();
                      _breathingController.value = 1.0;
                      timer.cancel();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: CustomColor.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  child: Text(action,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
