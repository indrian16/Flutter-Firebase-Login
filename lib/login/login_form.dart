import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/bloc.dart';

import 'package:login_firebase/user_repository.dart';
import 'package:login_firebase/forgot_password/forgot_password.dart';

class LoginForm extends StatefulWidget {

  final UserRepository userRepository;

  const LoginForm({Key key, @required this.userRepository})
          : assert(userRepository != null),
            super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get _isPopulated {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  bool _isLoginButtonEnabled(LoginState state) {
    return _isPopulated && state.isFormValid && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _loginBloc,
      builder: (_, LoginState state) {
        return Container(
          width: double.infinity,
          height: 300.0,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: 'Email Address',
                            icon: Icon(Icons.email,
                                color: Colors.deepOrangeAccent),
                          ),
                        cursorColor: Theme.of(context).primaryColor,
                        autocorrect: true,
                        autovalidate: true,
                        validator: (_) {

                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                      ),
                      SizedBox(height: 6.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Passwrod',
                          icon: Icon(Icons.security,
                              color: Colors.deepOrangeAccent),
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                        obscureText: true,
                        autocorrect: true,
                        autovalidate: true,
                        validator: (_) {

                          return !state.isPasswordValid ? 'Invalid Password' : null;
                        },
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () => _isLoginButtonEnabled(state)
                                            ? _onFormSubmiited()
                                            : null,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'Arimo', color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      InkWell(
                        onTap: () {

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(
                                userRepository: widget.userRepository,
                              )
                            )
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontFamily: 'Arimo', color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _onEmailChanged() {
    _loginBloc.dispatch(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmiited() {

    print('submitted');
    _loginBloc.dispatch(
      LoginWithEmailPressed(
        email: _emailController.text,
        password: _passwordController.text
      )
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
