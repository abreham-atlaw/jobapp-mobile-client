import 'package:jobapp/apps/auth/application/events/signup_event.dart';
import 'package:jobapp/apps/auth/application/handlers/signup_handler.dart';
import 'package:jobapp/apps/auth/application/states/signup_state.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';

class SignupBloc extends AsyncBloc<SignupState> {
  SignupBloc(super.initialState) {
    on<SignupEvent>(SignupHandler(this).handle);
  }
}
