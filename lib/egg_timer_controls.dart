import 'package:flutter/material.dart';
import './egg_timer_button.dart';

class EggtimerControls extends StatefulWidget {
  @override
  _EggtimerControlsState createState() => _EggtimerControlsState();
}

class _EggtimerControlsState extends State<EggtimerControls> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            EggTimerButon(
              icon: Icons.refresh,
              text: 'RESTART',
            ),
            Expanded(
              child: Container(),
            ),
            EggTimerButon(
              icon: Icons.arrow_back,
              text: 'RESET',
            ),
          ],
        ),
        EggTimerButon(
          icon: Icons.pause,
          text: 'PAUSE',
        ),
      ],
    );
  }
}
