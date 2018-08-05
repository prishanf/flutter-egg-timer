import 'package:flutter/material.dart';
import './egg_timer_knob.dart';
import 'dart:math';

final Color GRADIANT_TOP = const Color(0xFFF5F5F5);
final Color GRADIANT_BOTTOM = const Color(0xFFE8E8E8);

class EggTimerDial extends StatefulWidget {
  @override
  _EggTimerDialState createState() => _EggTimerDialState();
}

class _EggTimerDialState extends State<EggTimerDial> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      painter: TickPainter(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(65.0),
                    child: EggTimerKnob(),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Paint dialArrowPaint;

  ArrowPainter() : dialArrowPaint = Paint() {
    dialArrowPaint.color = Colors.black;
    dialArrowPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    canvas.translate(size.width / 2, 0.0);
    Path path = Path();
    path.moveTo(0.0, -15.0);
    path.lineTo(15.0, 5.0);
    path.lineTo(-15.0, 5.0);
    path.close();
    canvas.drawPath(path, dialArrowPaint);
    canvas.drawShadow(path, Colors.black, 3.0, false);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TickPainter extends CustomPainter {
  final LONG_TICK = 14.0;
  final SHOT_TICK = 4.0;

  final double tickCount;
  final int ticksPerSection;
  final double tickInset;
  final Paint tickPaint;
  final textPainter;
  final textStyle;

  TickPainter({
    this.tickCount = 35.0,
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
