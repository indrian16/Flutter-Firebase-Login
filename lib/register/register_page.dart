import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Account'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            height: 200.0,
            child: Form(
              autovalidate: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Email', icon: Icon(Icons.email)),
                    cursorColor: Theme.of(context).primaryColor,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.security)),
                    obscureText: true,
                    cursorColor: Theme.of(context).primaryColor,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.deepOrangeAccent,
                    child: Text(
                      'Create now',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      );
  }
}
