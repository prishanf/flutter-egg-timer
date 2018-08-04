import 'package:flutter/material.dart';

final Color GRADIANT_TOP = const Color(0xFFF5F5F5);
final Color GRADIANT_BOTTOM = const Color(0xFFE8E8E8);

class EggTimerKnob extends StatefulWidget {
  @override
  _EggTimerKnobState createState() => _EggTimerKnobState();
}

class _EggTimerKnobState extends State<EggTimerKnob> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.INFINITY,
          height: double.INFINITY,
          child: CustomPaint(
            painter: ArrowPainter(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
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
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: const Color(0xFFFDFDFDF),
                  width: 1.5,
                )),
            child: Center(
              child: Image.network(
                'https://avatars3.githubusercontent.com/u/14101776?s=400&v=4',
                width: 50.0,
                height: 50.0,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
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
