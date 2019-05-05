import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

import 'package:login_firebase/user_repository.dart';
import 'package:login_firebase/utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.isEmpty();

  @override
  Stream<LoginState> transform(
    Stream<LoginEvent> events, 
    Stream<LoginState> Function(LoginEvent event) next) {

      final observableStream = events as Observable<LoginEvent>;
      final nonDebounce = observableStream.where((event) {

        return (event is! EmailChanged && event is! PasswordChanged);
      });
      final debounceStream = observableStream.where((event) {

        return (event is EmailChanged || event is PasswordChanged);
      }).debounce(Duration(milliseconds: 300));
      return super.transform(nonDebounce.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    
    if (event is EmailChanged) {

      yield* _mapEmailChangedToState(event.email);
    }

    if (event is PasswordChanged) {

      yield* _mapPasswordChangedToState(event.password);
    }

    if (event is LoginWithEmailPressed) {

      yield* _mapLoginWithEmailPressed(
        email: event.email,
        password: event.password
      );
    }

    if (event is LoginWithGooglePressed) {

      yield* _mapLoginWithGooglePressed();
    }

    if (event is TestEvent) {

      yield LoginState.isFailure();
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {

    yield currentState.update(
      isEmailValid: Validators.isEmailValid(email)
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {

    yield currentState.update(
      isPasswordValid: Validators.isPasswordValid(password)
    );
  }

  Stream<LoginState> _mapLoginWithEmailPressed({
    String email,
    String password
  }) async* {

    yield LoginState.isLoading();

    try {
      
      await _userRepository.signInWithEmailAndPass(email, password);
      yield LoginState.isSuccess();
    } catch (_) {

      yield LoginState.isFailure();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressed() async* {

    yield LoginState.isLoading();
    try {
      
      await _userRepository.signInWithGoogle();
      yield LoginState.isSuccess();
    } catch (_) {

      yield LoginState.isFailure();
    }
  }
}
