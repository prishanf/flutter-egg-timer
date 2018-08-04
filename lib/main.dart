import 'package:flutter/material.dart';
import 'package:fluttery/framing.dart';
import './egg_timer_time_display.dart';
import './egg_timer_controls.dart';
import './egg_timer_dial.dart';

final Color GRADIANT_TOP = const Color(0xFFF5F5F5);
final Color GRADIANT_BOTTOM = const Color(0xFFE8E8E8);

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [GRADIANT_TOP, GRADIANT_BOTTOM],
        )),
        child: Center(
          child: Column(
            children: <Widget>[
              EggTimerDisplay(),
              EggTimerDial(),
              Expanded(
                child: Container(),
              ),
              EggtimerControls(),
            ],
          ),
        ),
      ),
    );
  }
}
