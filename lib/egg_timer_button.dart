import 'package:flutter/material.dart';

class EggTimerButon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: const Color(0x22000000),
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.0, top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 3.0),
              child: Icon(
                Icons.pause,
                color: Colors.black,
              ),
            ),
            Text(
              'Pause',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
