import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(4.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(-4.0, -11.0),
                blurRadius: 15.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Firebase Login',
              style: TextStyle(
                  fontFamily: 'Arimo-Bold',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.0),
            Form(
              autovalidate: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        icon: Icon(Icons.email, color: Colors.deepOrangeAccent),
                      ),
                      cursorColor: Theme.of(context).primaryColor),
                  SizedBox(height: 6.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Passwrod',
                      icon:
                          Icon(Icons.security, color: Colors.deepOrangeAccent),
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: true,
                  ),
                  SizedBox(height: 8.0),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          color: Colors.white
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        color: Colors.grey
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
