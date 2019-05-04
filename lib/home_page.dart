import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String _displayName;

  const HomePage({Key key, @required String displayName})
      : assert(displayName != null),
        _displayName = displayName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(fontFamily: 'Arimo-Bold')),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.exit_to_app, color: Colors.white),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Hi, Thanks for log in',
                    style: TextStyle(
                      fontFamily: 'Arimo-Bold',
                      fontSize: 20.0
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      _displayName,
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 18.0
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset('assets/logo-standard.png', width: 165),
            ),
          )
        ],
      ),
    );
  }
}
