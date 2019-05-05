import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

import 'package:login_firebase/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _userRepository;

  @override
  AuthenticationState get initialState => Uninitilized();

  AuthenticationBloc({UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    
    if (event is AppStarted) {

      yield* _mapAppStartedToState();
    }

    if (event is LoggedIn) {

      yield* _mapLoggedInToState();
    }

    if (event is LoggedOut) {

      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {

    try {
      
      final isSignedIn = await _userRepository.isSignedIn();

      if (isSignedIn) {

        final displayEmail = await _userRepository.getUserEmail();
        yield Authenticated(
          displayEmail: displayEmail
        );
      } else {

        yield Unauthenticated();
      }
    } catch (_) {

      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {

    yield Authenticated(
      displayEmail: await _userRepository.getUserEmail()
    );
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {

    yield Unauthenticated();
    _userRepository.signOut();
  }
}
