import 'dart:async';

import 'package:dunder_mifflin/data/blocs/login_event.dart';
import 'package:dunder_mifflin/data/blocs/login_state.dart';
import 'package:dunder_mifflin/data/models/user_model.dart';
import 'package:dunder_mifflin/data/repositories/user_repository.dart';

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
    User user = User();

    _outputLoginController.add(LoginLoadingState());

    if (event is PostLogin) {
      user = await _repository.login(event.user);
    }
  }
}
