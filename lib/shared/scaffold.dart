import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;
  final BottomNavigationBar bottomNavigationBar;

  DefaultScaffold(
      {@required this.title,
      @required this.body,
      this.actions,
      this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(title),
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
