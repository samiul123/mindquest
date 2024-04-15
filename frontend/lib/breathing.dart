import 'package:flutter/material.dart';
import 'package:frontend/utils.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  _BreathingScreenState createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> with TickerProviderStateMixin {
  // AnimationController _breathingController();
  var _breathe = 1.0;
  String action = "Start";
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
        vsync: this, value: _breathe, duration: const Duration(milliseconds: 4000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("Completed: ${_breathingController.value}");
        // Hold the animation for 4 seconds
        Future.delayed(const Duration(seconds: 4), () {
          _breathingController.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        print("Dismissed: ${_breathingController.value}");
        Future.delayed(const Duration(seconds: 4), () {
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
  }

  @override
  Widget build(BuildContext context) {
    final size = 200.0 - 100.0 * _breathe;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SizedBox(
              height: size,
              width: size,
              child: Material(
                borderRadius: BorderRadius.circular(size),
                color: Colors.white,
                child: Icon(
                  Icons.circle,
                  size: 100,
                  color: Colors.grey[850],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100, // Adjust the distance from the bottom as needed
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (action == "Start") {
                    _breathingController.reverse();
                    setState(() {
                      action = "Stop";
                    });
                  } else {
                    setState(() {
                      action = "Start";
                    });
                    _breathingController.stop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  backgroundColor: CustomColor.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                ),
                child: Text(action, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400,)),
              ),
            ),
          ),
        ],
      )


    );
  }
}