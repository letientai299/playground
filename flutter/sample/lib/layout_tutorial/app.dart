import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final EdgeInsets _padding = EdgeInsets.all(32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App 2"),
        ),
        body: ListView(
          children: [
            _imgSection(),
            _titleSection(),
            _buttonSection(context),
            _textSection(),
          ],
        ));
  }

  _titleSection() => Container(
        padding: _padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Oeschinen Lake Campground",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text("Kanderstedg, Switzarland")
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red,
            ),
            Text('41'),
          ],
        ),
      );

  _buttonSection(BuildContext context) {
    var buttons = <String, IconData>{
      "Call": Icons.call,
      "Route": Icons.near_me,
      "Share": Icons.share,
    };

    var children = buttons.entries.map((me) {
      var txt = me.key.toUpperCase();
      return TextButton.icon(
        icon: Icon(me.value, color: Colors.blue),
        label: Text(txt),
        onPressed: () => {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$txt clicked'),
              duration: Duration(seconds: 2),
            ),
          )
        },
      );
    }).toList();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 60, right: 60),
    );
  }

  _textSection() => Container(
        padding: _padding,
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          '1 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '2 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '3 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '4 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '14 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '12 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '12 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '13 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '17 lake, which warms to 20 degrees Celsius in the summer. Activities '
          '13 llake, which warms to 20 degrees Celsius in the summer. Activities ',
          softWrap: true,
        ),
      );

  _imgSection() => Container(
        child: Image.asset(
          'lib/layout_tutorial/img/lake.webp',
          width: 600,
          height: 240,
          fit: BoxFit.cover,
        ),
      );
}
