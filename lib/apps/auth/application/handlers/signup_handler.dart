import 'package:jobapp/apps/auth/application/events/signup_event.dart';
import 'package:jobapp/apps/auth/application/states/signup_state.dart';
import 'package:jobapp/apps/auth/data/repositories/auth_repository.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/lib/async_bloc/async_handler.dart';

class SignupHandler extends AsyncEventHandler<SignupEvent, SignupState> {
  final AuthRepository _repository = AuthProviders.provideAuthRepository();

  SignupHandler(super.parentBloc);

  @override
  onEvent(SignupEvent event, SignupState state) async {
    await state.form.isValid(throwError: true);
    await _repository.signup(state.form.phoneNumber.getValue()!,
        state.form.fullName.getValue()!, state.form.password.getValue()!, state.skills);
  }
}
