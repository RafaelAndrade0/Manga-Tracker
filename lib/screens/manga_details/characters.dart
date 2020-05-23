import 'package:flutter/material.dart';

class Characters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 80),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: CircleAvatar(
                maxRadius: 40.0,
                backgroundImage: NetworkImage(
                    'https://avatarfiles.alphacoders.com/629/62922.jpg'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: CircleAvatar(
                maxRadius: 40.0,
                backgroundImage: NetworkImage(
                    'https://avatarfiles.alphacoders.com/618/61857.jpg'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: CircleAvatar(
                maxRadius: 40.0,
                backgroundImage: NetworkImage(
                    'https://avatarfiles.alphacoders.com/837/83722.jpg'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: CircleAvatar(
                maxRadius: 40.0,
                backgroundImage: NetworkImage(
                    'https://avatarfiles.alphacoders.com/783/78320.jpg'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: CircleAvatar(
                maxRadius: 40.0,
                backgroundImage: NetworkImage(
                    'https://avatarfiles.alphacoders.com/102/102646.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
