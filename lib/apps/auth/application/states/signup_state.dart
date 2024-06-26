import 'package:jobapp/apps/auth/application/forms/signup_form.dart';
import 'package:jobapp/lib/async_bloc/async_state.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class SignupState extends AsyncState {
  SignupForm form = SignupForm();
  List<String> skills = [];

  @override
  BaseState newInstance() {
    return SignupState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as SignupState).form = form;
    newState.skills = skills;
  }
}
