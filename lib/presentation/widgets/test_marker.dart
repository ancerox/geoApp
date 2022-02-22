import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestMakerScreen extends StatelessWidget {
  const TestMakerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: StartMakerPainter(),
          ),
        ),
      ),
    );
  }
}

class StartMakerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;

    canvas.drawCircle(
      Offset(20, size.height - 20),
      20,
      blackPaint,
    );
    canvas.drawCircle(
      Offset(20, size.height - 20),
      7,
      whitePaint,
    );

    // draw a black box
    final path = Path();

    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    // shadow
    canvas.drawShadow(path, Colors.black, 10, false);
    //box
    canvas.drawPath(path, whitePaint);

    // Black box

    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    const textSpan = TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      text: '55',
    );

    final minutesPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout();

    minutesPainter.paint(canvas, Offset(55, 35));

    const minutesText = TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
      text: 'Mn',
    );

    final distancePainter = TextPainter(
        text: minutesText,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout();

    distancePainter.paint(canvas, Offset(55, 65));

    // DESCRIPTION

    final tempDestino = 'Mercad de pedr';

    const locatinText = TextSpan(
      style: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
      text: 'Mi casa',
    );

    final locatinPainter = TextPainter(
        text: locatinText,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(
        minWidth: size.width - 135,
        maxWidth: size.width - 135,
      );

    locatinPainter.paint(canvas, Offset(120, 35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return true;
  }
}
