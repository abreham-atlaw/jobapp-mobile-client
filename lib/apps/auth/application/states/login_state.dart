import 'package:jobapp/apps/auth/application/forms/login_form.dart';
import 'package:jobapp/lib/async_bloc/async_state.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class LoginState extends AsyncState {
  LoginForm form = LoginForm();

  @override
  BaseState newInstance() {
    return LoginState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as LoginState).form = form;
  }
}
