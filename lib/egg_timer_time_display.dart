import 'package:flutter/material.dart';

class EggTimerDisplay extends StatefulWidget {
  @override
  _EggTimerDisplayState createState() => _EggTimerDisplayState();
}

class _EggTimerDisplayState extends State<EggTimerDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 35.0,
      ),
      child: Text(
        '15:23',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'BebasNeue',
          fontSize: 150.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 10.0,
        ),
      ),
    );
  }
}
