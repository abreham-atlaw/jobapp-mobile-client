import 'package:jobapp/apps/auth/application/events/login_event.dart';
import 'package:jobapp/apps/auth/application/states/login_state.dart';
import 'package:jobapp/apps/auth/data/repositories/auth_repository.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/lib/async_bloc/async_error.dart';
import 'package:jobapp/lib/async_bloc/async_handler.dart';
import 'package:jobapp/lib/async_bloc/error_mapper.dart';
import 'package:jobapp/lib/network/network_client.dart';

class LoginHandler extends AsyncEventHandler<LoginEvent, LoginState> {



  final AuthRepository _repository = AuthProviders.provideAuthRepository();

  LoginHandler(super.parentBloc): super(errorMapper: ErrorMapper(mapper:
  (dynamic error) {
    if(error is ApiException && error.statusCode == 401){
      return AsyncError("Incorrect Username or Password");
    }
  }));

  @override
  onEvent(LoginEvent event, LoginState state) async {
    await state.form.isValid(throwError: true);
    await _repository.login(
        state.form.username.getValue()!, state.form.password.getValue()!);
  }
}
