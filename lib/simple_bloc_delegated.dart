import 'package:bloc/bloc.dart';

class SimpleBlocDelegated extends BlocDelegate {

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }
}