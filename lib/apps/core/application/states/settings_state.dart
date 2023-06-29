import 'package:jobapp/lib/async_bloc/async_state.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class SettingsState extends BaseState {
  AsyncState logoutState = AsyncState();

  @override
  BaseState newInstance() {
    return SettingsState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as SettingsState).logoutState = logoutState;
  }
}
