import 'package:flutter/material.dart';

import './login.dart';
import 'package:login_firebase/custom_icon_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 80,
          height: 1.0,
          decoration: BoxDecoration(color: Colors.black26.withOpacity(.2)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 54.0),
                  child: Image.asset('assets/logo-standard.png'),
                ),
                LoginForm(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    children: <Widget>[
                      _horizontalLine(),
                      Text(
                        'Social Login',
                        style: TextStyle(fontFamily: 'Arimo', fontSize: 16.0),
                      ),
                      _horizontalLine(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[GoogleButton(), FacebookButton()],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          color: Colors.grey[800]
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () {},
      icon: Icon(CustomIcon.google_plus__3_, color: Colors.white, size: 18),
      color: Colors.redAccent,
      label: Text(
        'Google',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () {},
      icon: Icon(CustomIcon.facebook__1_, color: Colors.white, size: 18),
      color: Colors.blueAccent,
      label: Text(
        'Facebook',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
