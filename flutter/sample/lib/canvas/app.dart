import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<Offset?> _points = <Offset?>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox box = context.findRenderObject() as RenderBox;
              var local = box.globalToLocal(details.globalPosition);
              // must create new list due to the shouldRepaint function below!
              _points = List.from(_points)..add(local);
            });
          },
          onPanEnd: (details) {
            _points.add(null);
          },
          child: CustomPaint(
            painter: SignaturePainter(_points),
            size: Size.infinite,
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cached_sharp),
        onPressed: () {
          setState(() {
            _points = List.empty();
          });
        },
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this._points);

  final List<Offset?> _points;

  @override
  void paint(Canvas canvas, Size size) {
    if (_points.isEmpty && canvas.getSaveCount() > 1) {
      print("restored ${canvas.getSaveCount()}");
      canvas.restore();
      return;
    }

    var paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < _points.length - 1; i++) {
      var p1 = _points[i];
      var p2 = _points[i + 1];
      if (p1 == null || p2 == null) {
        continue;
      }
      canvas.drawLine(p1, p2, paint);
    }
    canvas.save();
  }

  @override
  bool shouldRepaint(SignaturePainter other) => other._points != _points;
}
