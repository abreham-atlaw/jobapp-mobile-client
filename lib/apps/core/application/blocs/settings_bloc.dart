import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/auth/data/repositories/auth_repository.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/apps/core/application/events/settings_evetns.dart';
import 'package:jobapp/apps/core/application/states/settings_state.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class SettingsBloc extends AsyncBloc<SettingsState> {
  final AuthRepository _authRepository = AuthProviders.provideAuthRepository();

  SettingsBloc(super.initialState) {
    on<LogoutEvent>(_handleLogout);
  }

  @override
  Future<void> onInit() async{
    await super.onInit();
    state.me = await _authRepository.whoAmI();
  }

  _handleLogout(LogoutEvent event, Emitter emitter) async {
    await asyncCall(event, emitter,
        (event, state) async => {await _authRepository.logout()},
        stateGetter: (BaseState state) {
      return (state as SettingsState).logoutState;
    });
  }

}
