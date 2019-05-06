import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import './login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_firebase/user_repository.dart';
import './bloc/bloc.dart';
import 'package:login_firebase/authentication/bloc.dart';

import 'package:login_firebase/register/register.dart';
import 'package:login_firebase/utils/custom_icon_icons.dart';

class LoginPage extends StatefulWidget {
  final UserRepository _userRepository;

  LoginPage({Key key, @required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepository = userRepo,
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginBloc _loginBloc;
  UserRepository get _userRepository => widget._userRepository;

  Widget _horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 80,
          height: 1.0,
          decoration: BoxDecoration(color: Colors.black26.withOpacity(.2)),
        ),
      );

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(userRepository: _userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: BlocProvider(
        bloc: _loginBloc,
        child: BlocListener(
          bloc: _loginBloc,
          listener: (_, state) => _blocListener(state),
          child: BlocBuilder(
            bloc: _loginBloc,
            builder: (_, state) {
              return _loginPageUI(state);
            },
          ),
        ),
      ),
    );
  }

  _blocListener(LoginState state) {
    if (state.isLoading) {
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          duration: Duration(minutes: 5),
          backgroundColor: Colors.black,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Just a moment',
                style: TextStyle(
                    fontFamily: 'Arimo', fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(
                width: 30.0,
                height: 30.0,
                child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation(Colors.white)),
              )
            ],
          ),
        ));
    }

    if (state.isFailure) {
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Login Failure',
                style: TextStyle(
                    fontFamily: 'Arimo',
                    fontSize: 16.0,
                    color: Colors.redAccent),
              ),
              SizedBox(
                width: 30.0,
                height: 30.0,
                child: Icon(Icons.error, color: Colors.redAccent),
              )
            ],
          ),
        ));
    }

    if (state.isSubmitting) {

      FocusScope.of(context).requestFocus(new FocusNode());
    }

    if (state.isSuccess) {
      
      BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
    }
  }

  Widget _loginPageUI(LoginState state) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 54.0),
                child: Image.asset(
                  'assets/logo-standard.png',
                  width: 280,
                ),
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterPage(
                            userRepository: _userRepository,
                          )));
                    },
                    child: Text(
                      'Create an account',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
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

class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).dispatch(LoginWithGooglePressed());
      },
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
