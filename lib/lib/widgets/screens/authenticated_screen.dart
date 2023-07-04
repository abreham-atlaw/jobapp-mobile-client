import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobapp/apps/auth/data/models/authentication_status.dart';
import 'package:jobapp/apps/auth/data/repositories/auth_repository.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';
import 'package:jobapp/lib/async_bloc/async_events.dart';
import 'package:jobapp/lib/async_bloc/async_state.dart';
import 'package:jobapp/lib/async_bloc/async_status.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/utils/token_storage.dart';
import 'package:jobapp/lib/widgets/screens/app_scaffold.dart';
import 'package:jobapp/lib/widgets/screens/loading_screen.dart';

import 'error_screen.dart';

class AuthenticationState extends AsyncState {
  AuthenticationStatus authenticationStatus = AuthenticationStatus.none;

  @override
  BaseState newInstance() {
    return AuthenticationState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as AuthenticationState).authenticationStatus =
        authenticationStatus;
  }
}

class AuthenticationBloc extends AsyncBloc<AuthenticationState> {
  final AuthRepository _repository = AuthProviders.provideAuthRepository();

  AuthenticationBloc(super.initialState);

  @override
  onInit() async {
    await super.onInit();
    state.authenticationStatus = await _repository.getAuthenticationStatus();
  }
}

class AuthenticatedScreen extends StatelessWidget {
  Widget child;
  Widget? loadingScreen;
  Widget? failedScreen;
  String redirectTo;
  Map<AuthenticationStatus, String> redirectMap;
  List<AuthenticationStatus> validStatuses;

  AuthenticatedScreen(
      {super.key,
      required this.child,
      this.redirectTo = "/auth/review/",
      this.loadingScreen,
      this.failedScreen,
      Map<AuthenticationStatus, String>? redirectMap,
      List<AuthenticationStatus>? validStatuses})
      : redirectMap = {
          AuthenticationStatus.lowCredit: "/auth/low-credit",
          AuthenticationStatus.none: "/auth/login",
          AuthenticationStatus.review: "/auth/review"
        },
        validStatuses = validStatuses ?? [AuthenticationStatus.authenticated]{
      this.redirectMap.addAll(redirectMap??{});
    }

  bool _isValidStatus(AuthenticationStatus status) {
    return (validStatuses.contains(status));
  }

  String _getRedirectPath(AuthenticationStatus status) {
    var mapValue = redirectMap[status];
    return mapValue ?? redirectTo;
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) =>
            AuthenticationBloc(AuthenticationState()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
          switch (state.initStatus) {
            case AsyncStatus.none:
              context.read<AuthenticationBloc>().add(InitializeEvent());
              return loadingScreen ?? LoadingScreen(state);
            case AsyncStatus.loading:
              return loadingScreen ?? LoadingScreen(state);
            case AsyncStatus.done:
              if (_isValidStatus(state.authenticationStatus)) {
                return child;
              } else {
                RoutingUitls.redirect(
                    _getRedirectPath(state.authenticationStatus), context);
                return const SizedBox.shrink();
              }
            case AsyncStatus.failed:
              return failedScreen ?? ErrorScreen(state);
          }
        }),
      ),
    );
  }
}
