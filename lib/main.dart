import 'package:flutter/material.dart';
import 'package:fluttery/framing.dart';
import './egg_timer_time_display.dart';
import './egg_timer_button.dart';
import './egg_timer_controls.dart';

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
      body: new Center(
        child: new Column(
          children: <Widget>[
            EggTimerDisplay(),
            RandomColorBlock(
              width: double.INFINITY,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 45.0,
                  right: 45.0,
                ),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: RandomColorBlock(
                    width: double.INFINITY,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            EggtimerControls(),
          ],
        ),
      ),
    );
  }
}
