import 'package:flutter/material.dart';
import 'package:manga_tracker/screens/authenticate/login.dart';
import 'package:manga_tracker/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  var showLogin = true;

  void toggleLoginView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showLogin
          ? Login(toggleLoginView: toggleLoginView)
          : Register(toggleLoginView: toggleLoginView),
    );
  }
}
