import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

import 'package:login_firebase/utils/validators.dart';

import 'package:login_firebase/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transform(
    Stream<RegisterEvent> events, 
    Stream<RegisterState> Function(RegisterEvent event) next) {

      final observableStream = events as Observable<RegisterEvent>;
      final nonDebounce = observableStream.where((event) {

        return (event is! EmailChanged && event is! PasswordChanged);
      });
      final debounceStream = observableStream.where((event) {

        return (event is EmailChanged || event is PasswordChanged);
      }).debounce(Duration(milliseconds: 300));
      return super.transform(nonDebounce.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    
    if (event is EmailChanged) {

      yield currentState.update(
        isEmailValid: Validators.isEmailValid(event.email)
      );
    }

    if (event is PasswordChanged) {

      yield currentState.update(
        isPasswordValid: Validators.isPasswordValid(event.password)
      );
    }

    if (event is Submitted) {

      yield* _mapSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapSubmittedToState(
    String email,
    String password
  ) async* {

    yield RegisterState.loading();

    try {
      
      await _userRepository.signUp(
        email: email,
        password: password
      );
      yield RegisterState.success();
    } catch (_) {

      yield RegisterState.failure();
    }
  }
}
