import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

import 'package:login_firebase/utils/validators.dart';
import 'package:login_firebase/user_repository.dart';

class ForgotpasswordBloc extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {

  final UserRepository _userRepository;

  ForgotpasswordBloc({@required UserRepository userRepository})
        : assert(userRepository != null),
          _userRepository = userRepository;

  @override
  ForgotpasswordState get initialState => ForgotpasswordState.isEmpty();

  @override
  Stream<ForgotpasswordState> transform(
    Stream<ForgotpasswordEvent> events, 
    Stream<ForgotpasswordState> Function(ForgotpasswordEvent event) next) {

      final observableStream = events as Observable<ForgotpasswordEvent>;
      final nonDebounce = observableStream.where((event) {

        return (event is! EmailChanged);
      });
      final debounceStream = observableStream.where((event) {

        return (event is EmailChanged);
      }).debounce(Duration(milliseconds: 300));
      return super.transform(nonDebounce.mergeWith([debounceStream]), next);
  }

  @override
  Stream<ForgotpasswordState> mapEventToState(
    ForgotpasswordEvent event,
  ) async* {
    
    if (event is EmailChanged) {

      yield currentState.update(
        isEmailValid: Validators.isEmailValid(event.email)
      );
    }

    if (event is ResetPasswordPressed) {

      yield* _mapResetPwdToState(event.email);
    }
  }

  Stream<ForgotpasswordState> _mapResetPwdToState(String email) async* {

    yield ForgotpasswordState.isLoading();

    try {
      
      await _userRepository.requestResetPassword(email: email);
      yield ForgotpasswordState.isSuccess();

    } catch (_) {

      yield ForgotpasswordState.isFailure();
    }
  }
}
