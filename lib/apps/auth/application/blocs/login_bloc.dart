import 'package:jobapp/apps/auth/application/events/login_event.dart';
import 'package:jobapp/apps/auth/application/handlers/login_hander.dart';
import 'package:jobapp/apps/auth/application/states/login_state.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';

class LoginBloc extends AsyncBloc<LoginState> {
  LoginBloc(super.initialState) {
    on<LoginEvent>(LoginHandler(this).handle);
  }
}
