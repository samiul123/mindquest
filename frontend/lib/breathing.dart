import 'package:flutter/material.dart';

class BreathingScreen extends StatefulWidget {
  @override
  _BreathingScreenState createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> with TickerProviderStateMixin {
  // AnimationController _breathingController();
  var _breathe = 0.0;

  @override
  void initState() {
    super.initState();

    AnimationController _breathingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Hold the animation for 4 seconds
        Future.delayed(Duration(seconds: 4), () {
          _breathingController.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {

        Future.delayed(Duration(seconds: 4), () {
          _breathingController.forward();
        });
      }
    });

    _breathingController.addListener(() {
      setState(() {
        _breathe = _breathingController.value;
      });
    });
    Future.delayed(Duration(seconds: 4), () {
      _breathingController.forward();
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = 200.0 - 100.0 * _breathe;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Container(
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

    );
  }
}