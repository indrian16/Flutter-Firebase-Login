import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Just a moment',
                style: TextStyle(
                  fontFamily: 'Arimo-Bold', fontSize: 18.0
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(
              'assets/logo-standard.png',
              width: 165
            ),
          ),
        )
      ],
    ));
  }
}
