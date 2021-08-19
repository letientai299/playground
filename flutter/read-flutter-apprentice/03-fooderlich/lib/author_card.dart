import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';

class AuthorCard extends StatefulWidget {
  final String name;
  final String title;
  final ImageProvider imageProvider;

  const AuthorCard({
    Key? key,
    required this.name,
    required this.title,
    required this.imageProvider,
  }) : super(key: key);

  @override
  _AuthorCardState createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = FooderlichTheme.lightTextTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: widget.imageProvider,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name, style: textTheme.headline2),
              Text(widget.title, style: textTheme.bodyText1),
            ],
          ),
          Spacer(),
          IconButton(
            iconSize: 30,
            color: Colors.red[400],
            icon: Icon(_liked ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                _liked = !_liked;
              });
            },
          ),
        ],
      ),
    );
  }
}
