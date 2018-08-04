import 'package:flutter/material.dart';
import 'package:fluttery/framing.dart';
import './egg_timer_time_display.dart';

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
                  left: 30.0,
                  right: 30.0,
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
            RandomColorBlock(
              width: double.INFINITY,
              height: 50.0,
            ),
            RandomColorBlock(
              width: double.INFINITY,
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
