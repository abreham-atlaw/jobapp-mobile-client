import 'package:jobapp/apps/auth/application/events/login_event.dart';
import 'package:jobapp/apps/auth/application/states/login_state.dart';
import 'package:jobapp/apps/auth/data/repositories/auth_repository.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/lib/async_bloc/async_handler.dart';

class LoginHander extends AsyncEventHandler<LoginEvent, LoginState> {
  final AuthRepository _repository = AuthProviders.provideAuthRepository();

  LoginHander(super.parentBloc);

  @override
  onEvent(LoginEvent event, LoginState state) async {
    await state.form.isValid(throwError: true);
    await _repository.login(
        state.form.username.getValue()!, state.form.password.getValue()!);
  }
}
