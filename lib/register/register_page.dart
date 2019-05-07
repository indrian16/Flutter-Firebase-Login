import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register.dart';

import 'package:login_firebase/authentication/bloc.dart';
import 'package:login_firebase/user_repository.dart';

class RegisterPage extends StatefulWidget {
  final UserRepository _userRepository;

  RegisterPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserRepository get _userRepository => widget._userRepository;
  RegisterBloc _registerBloc;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPopulated() {

    return _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  }

  bool _isEnabledCreateButton(RegisterState state) {

    return state.isFormValid && _isPopulated() && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(userRepository: _userRepository);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Create Account'),
        ),
        body: BlocListener(
          bloc: _registerBloc,
          listener: (_, RegisterState state) => _blocListener(state),
          child: BlocBuilder(
            bloc: _registerBloc,
            builder: (_, RegisterState state) => _blocBuilder(state),
          ),
        ));
  }

  _blocListener(RegisterState state) {
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
                'Create account has been Failure',
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
      Navigator.of(context).pop();
    }
  }

  _blocBuilder(RegisterState state) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        height: 230.0,
        child: Form(
          autovalidate: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email', icon: Icon(Icons.email)),
                cursorColor: Theme.of(context).primaryColor,
                autovalidate: true,
                autocorrect: true,
                autofocus: true,
                validator: (_) {

                  return !state.isEmailValid
                            ? 'Invalid Email'
                            : null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password', icon: Icon(Icons.security)),
                obscureText: true,
                cursorColor: Theme.of(context).primaryColor,
                autocorrect: true,
                autovalidate: true,
                validator: (_) {

                  return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                },
              ),
              MaterialButton(
                onPressed: () {
                  
                  return _isEnabledCreateButton(state)
                            ? _onSubmitted()
                            : print('disabled');
                },
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
    );
  }

  void _onEmailChanged() {
    _registerBloc.dispatch(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _registerBloc.dispatch(PasswordChanged(password: _passwordController.text));
  }

  void _onSubmitted() => _registerBloc.dispatch(Submitted(
      email: _emailController.text, password: _passwordController.text));

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _registerBloc.dispose();
    super.dispose();
  }
}
