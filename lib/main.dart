import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'simple_bloc_delegated.dart';
import 'user_repository.dart';

import 'authentication/bloc.dart';

import 'package:login_firebase/login/login.dart';
import 'splash_screen.dart';
import 'home_page.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegated();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);

    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Firebase',
      theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
      home: BlocBuilder(
        bloc: _authenticationBloc,
        builder: (_, AuthenticationState state) {
          if (state is Uninitilized) {
            return SplashScreen();
          }

          if (state is Authenticated) {
            return HomePage(displayName: state.displayEmail);
          }

          if (state is Unauthenticated) {
            return LoginPage();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
