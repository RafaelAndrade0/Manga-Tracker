import 'package:flutter/material.dart';

class DialogStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 200.0,
        width: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'READ',
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'WANT TO READ',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'DROPPED',
                style: TextStyle(color: Colors.red, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
