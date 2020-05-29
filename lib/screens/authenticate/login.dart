import 'package:flutter/material.dart';
import 'package:manga_tracker/screens/wrapper.dart';
import 'package:manga_tracker/services/auth.dart';
import 'package:manga_tracker/shared/constants.dart';
import 'package:manga_tracker/shared/loading.dart';
import 'package:manga_tracker/shared/scaffold.dart';

class Login extends StatefulWidget {
  final Function toggleLoginView;
  Login({this.toggleLoginView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = '';
  var password = '';
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : DefaultScaffold(
            title: 'Login',
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () => widget.toggleLoginView(),
                icon: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                label: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
            body: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/bg1.png'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (val) => setState(() => email = val),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your email!' : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (val) => setState(() => password = val),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your password!' : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                    ),
                    RaisedButton(
                      color: Colors.grey,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => isLoading = true);
                          var result = await AuthService()
                              .signInWithEmailAndPassword(
                                  email: email, password: password);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Wrapper(),
                              ),
                              (Route<dynamic> route) => false);
                          if (result == null) {
                            setState(() => isLoading = false);
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
