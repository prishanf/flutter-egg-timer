import 'package:flutter/material.dart';

class EggTimerButon extends StatelessWidget {
final IconData icon;
final String text;

EggTimerButon({this.icon,this.text});

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
                icon,
                color: Colors.black,
              ),
            ),
            Text(
              text,
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
