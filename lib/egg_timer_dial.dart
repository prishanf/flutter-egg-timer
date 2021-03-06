import 'package:flutter/material.dart';
import './egg_timer_knob.dart';
import 'dart:math';
import 'package:fluttery/gestures.dart';

final Color GRADIANT_TOP = const Color(0xFFF5F5F5);
final Color GRADIANT_BOTTOM = const Color(0xFFE8E8E8);

class EggTimerDial extends StatefulWidget {
  final Duration currentTime;
  final Duration maxTime;
  final int ticksPersection;
  final Function(Duration) onTimeSelected;
  final Function(Duration) onDialStopTurning;

  EggTimerDial({
    this.currentTime = const Duration(minutes: 0),
    this.maxTime = const Duration(minutes: 35),
    this.ticksPersection = 5,
    this.onTimeSelected,
    this.onDialStopTurning,
  });
  @override
  _EggTimerDialState createState() => _EggTimerDialState();
}

class _EggTimerDialState extends State<EggTimerDial> {
  _rotationPercent() {
    return widget.currentTime.inSeconds / widget.maxTime.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return DialTurnGuestrureDetector(
      currentTime: widget.currentTime,
      maxTime: widget.maxTime,
      onTimeSelected: widget.onTimeSelected,
      onDialStopTurning: widget.onDialStopTurning,
      child: Container(
        width: double.INFINITY,
        child: Padding(
          padding: EdgeInsets.only(
            left: 45.0,
            right: 45.0,
          ),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [GRADIANT_TOP, GRADIANT_BOTTOM],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x44000000),
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0.0, 1.0),
                      )
                    ]),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.INFINITY,
                      height: double.INFINITY,
                      padding: const EdgeInsets.all(55.0),
                      child: CustomPaint(
                        painter: TickPainter(
                          tickCount: widget.maxTime.inMinutes,
                          ticksPerSection: widget.ticksPersection,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(65.0),
                      child: EggTimerKnob(
                        rotationPercent: _rotationPercent(),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class DialTurnGuestrureDetector extends StatefulWidget {
  final currentTime;
  final maxTime;
  final child;
  final Function(Duration) onTimeSelected;
  final Function(Duration) onDialStopTurning;

  DialTurnGuestrureDetector({
    this.child,
    this.currentTime,
    this.maxTime,
    this.onTimeSelected,
    this.onDialStopTurning,
  });

  @override
  _DialTurnGuestrureDetectorState createState() =>
      _DialTurnGuestrureDetectorState();
}

class _DialTurnGuestrureDetectorState extends State<DialTurnGuestrureDetector> {
  PolarCoord startDragCoord;
  Duration startDragTime;
  Duration selectedTime;

  _onRadialDragStart(PolarCoord coord) {
    startDragCoord = coord;
    startDragTime = widget.currentTime;
  }

  _onRadialDragUpdate(PolarCoord coord) {
    if (startDragCoord != null) {
      final angleDiff = coord.angle - startDragCoord.angle;
      final anglePercent = angleDiff / (2 * PI);
      final timeDiffInSeconds =
          (anglePercent * widget.maxTime.inSeconds).round();
      selectedTime =
          Duration(seconds: startDragTime.inSeconds + timeDiffInSeconds);
      print('new time ${selectedTime.inMinutes}');    
      widget.onTimeSelected(selectedTime);
    }
  }

  _onRadialDragEnd() {
   widget.onDialStopTurning(selectedTime);
   print('Selected Time $selectedTime');
    startDragCoord = null;
    startDragTime = null;
    selectedTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return RadialDragGestureDetector(
      onRadialDragStart: _onRadialDragStart,
      onRadialDragEnd: _onRadialDragEnd,
      onRadialDragUpdate: _onRadialDragUpdate,
      child: widget.child,
    );
  }
}

class TickPainter extends CustomPainter {
  final LONG_TICK = 14.0;
  final SHOT_TICK = 4.0;

  final int tickCount;
  final int ticksPerSection;
  final double tickInset;
  final Paint tickPaint;
  final textPainter;
  final textStyle;

  TickPainter({
    this.tickCount = 35,
    this.ticksPerSection = 5,
    this.tickInset = 0.0,
  })  : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
        textStyle = const TextStyle(
          color: Colors.black,
          fontFamily: 'BebasNeue',
          fontSize: 20.0,
        ) {
    tickPaint.color = Colors.black;
    tickPaint.strokeWidth = 1.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();

    final radius = size.width / 2;

    for (var i = 0; i < tickCount; i++) {
      final tickLength = i % ticksPerSection == 0 ? LONG_TICK : SHOT_TICK;
      canvas.drawLine(
        Offset(0.0, -radius),
        Offset(0.0, -radius - tickLength),
        tickPaint,
      );

      if (i % ticksPerSection == 0) {
        canvas.save();
        canvas.translate(0.0, (-size.width / 2) - 30);
        textPainter.text = TextSpan(
          text: '$i',
          style: textStyle,
        );
        textPainter.layout();

        // Figure out which qudraant the text is in.
        final tickPercent = i / tickCount;
        var quadrant;
        if (tickPercent < 0.25) {
          quadrant = 1;
        } else if (tickPercent < 0.5) {
          quadrant = 4;
        } else if (tickPercent < 0.75) {
          quadrant = 3;
        } else {
          quadrant = 2;
        }

        switch (quadrant) {
          case 4:
            canvas.rotate(-PI / 2);
            break;
          case 2:
          case 3:
            canvas.rotate(PI / 2);
            break;
        }

        print(tickPercent);
        print(quadrant);
        textPainter.paint(
            canvas,
            Offset(
              -textPainter.width / 2,
              -textPainter.height / 2,
            ));
        canvas.restore();
      }
      canvas.rotate(2 * PI / tickCount);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
