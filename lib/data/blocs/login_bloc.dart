import 'dart:async';

import 'package:dunder_mifflin/data/blocs/login_event.dart';
import 'package:dunder_mifflin/data/blocs/login_state.dart';
import 'package:dunder_mifflin/data/models/user_model.dart';
import 'package:dunder_mifflin/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  final _repository = UserRepository();

  final StreamController<LoginEvent> _inputLoginController =
      StreamController<LoginEvent>();

  final StreamController<LoginState> _outputLoginController =
      StreamController<LoginState>();

  Sink<LoginEvent> get inputLogin => _inputLoginController.sink;
  Stream<LoginState> get outputLogin => _outputLoginController.stream;

  LoginBloc() {
    _inputLoginController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(LoginEvent event) async {
    UserResponse userResponse = UserResponse();

    _outputLoginController.add(LoginLoadingState());

    if (event is PostLogin) {
      try {
        userResponse = await _repository.login(event.user);
        final prefs = await SharedPreferences.getInstance();
        if (userResponse.accessToken != null) {
          await prefs.setString('auth_token', userResponse.accessToken!);
          _outputLoginController
              .add(LoginLoadedState(userResponse: userResponse));
        }
      } catch (e) {
        final Exception exception;
        exception = Exception('Unknown error occurred: $e');
        _outputLoginController.add(LoginErrorState(exception: exception));
      }
    }

    if (event is CloseDilog) {
      _outputLoginController.add(LoginInitialState());
    }
  }
}
