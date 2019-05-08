import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/bloc.dart';

import 'package:login_firebase/user_repository.dart';

class ForgotPasswordPage extends StatefulWidget {
  final UserRepository userRepository;

  const ForgotPasswordPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotpasswordBloc _forgotpasswordBloc;

  final _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isEnabledResetButton(ForgotpasswordState state) {
    return state.isEmailValid && _emailController.text.isNotEmpty && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _forgotpasswordBloc =
        ForgotpasswordBloc(userRepository: widget.userRepository);
    _emailController.addListener(_onEmailChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(fontFamily: 'Arimo-Bold'),
        ),
      ),
      body: BlocListener(
          bloc: _forgotpasswordBloc,
          listener: (_, ForgotpasswordState state) => _onForgotListener(state),
          child: BlocBuilder(
            bloc: _forgotpasswordBloc,
            builder: (_, ForgotpasswordState state) => _onForgotUI(state),
          )),
    );
  }

  _onForgotListener(ForgotpasswordState state) {
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
                'Reset Password Failure',
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
      _emailController.text = '';
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          duration: Duration(minutes: 3),
          backgroundColor: Colors.black,
          content: Container(
            height: 80.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Success Reset your password',
                      style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 16.0,
                          color: Colors.green),
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: Icon(Icons.check, color: Colors.green),
                    )
                  ],
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Back To LoginPage',
                    style: TextStyle(fontFamily: 'Arimo', color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
    }
  }

  _onForgotUI(ForgotpasswordState state) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Your email'),
              cursorColor: Theme.of(context).primaryColor,
              autofocus: true,
              autocorrect: true,
              autovalidate: true,
              validator: (_) {
                return !state.isEmailValid ? 'Invalid Email' : null;
              },
            ),
            SizedBox(height: 6.0),
            MaterialButton(
              onPressed: () {
                _isEnabledResetButton(state)
                    ? _onResetEmail()
                    : print('disabled');
              },
              child: Text(
                'Reset Password',
                style: TextStyle(fontFamily: 'Arimo', color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }

  void _onEmailChanged() {
    _forgotpasswordBloc.dispatch(EmailChanged(email: _emailController.text));
  }

  void _onResetEmail() {
    _forgotpasswordBloc
        .dispatch(ResetPasswordPressed(email: _emailController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _forgotpasswordBloc.dispose();
    super.dispose();
  }
}
