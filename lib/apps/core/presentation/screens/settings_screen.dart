import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/core/application/blocs/settings_bloc.dart';
import 'package:jobapp/apps/core/application/events/settings_evetns.dart';
import 'package:jobapp/apps/core/application/states/settings_state.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/async_bloc/async_status.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/widgets/buttons/async_button.dart';
import 'package:jobapp/lib/widgets/buttons/base_button.dart';
import 'package:jobapp/lib/widgets/containers/full_container.dart';
import 'package:jobapp/lib/widgets/navigation/link.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';

class SettingsScreen extends AsyncBlocScreen<SettingsBloc, SettingsState> {
  const SettingsScreen({super.key});

  @override
  SettingsBloc onCreateBloc(SettingsState state) {
    return SettingsBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, SettingsState state) {
    if (state.logoutState.asyncStatus == AsyncStatus.done) {
      RoutingUitls.redirect("/", context);
    }
    return FullContainer(
        child: Column(
      children: [
        AsyncButton(
            state: state.logoutState,
            label: "Logout",
            onPressed: () {
              context.read<SettingsBloc>().add(LogoutEvent());
            }),
        SizedBox(
          height: SpacingConfigs.spacing2,
        ),
        BaseButton(
          onPressed: () {
            RoutingUitls.redirect("/core/job-map", context);
          },
          child: BodyText(
            "Back",
            color: ColorsConfigs.white,
          ),
        ),
      ],
    ));
  }

  @override
  SettingsState onCreateState() {
    return SettingsState();
  }
}
