



import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/auth/application/blocs/update_required_bloc.dart';
import 'package:jobapp/apps/auth/application/events/update_event.dart';
import 'package:jobapp/apps/auth/application/states/update_required_state.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/widgets/buttons/base_button.dart';
import 'package:jobapp/lib/widgets/containers/full_container.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class UpdateRequiredScreen extends AsyncBlocScreen<UpdateRequiredBloc, UpdateRequiredState>{
  const UpdateRequiredScreen({super.key});

  @override
  UpdateRequiredBloc onCreateBloc(UpdateRequiredState state) {
    return UpdateRequiredBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, UpdateRequiredState state) {
    return FullContainer(
      child: PercentageContainer(
        width: 0.8,
        child: Column(
          children: [
            PercentageContainer(
              width: 0.8,
              child: Image.asset("assets/images/update.png"),
            ),
            SizedBox(
              height: SpacingConfigs.spacing2,
            ),
            Heading1(
                textAlign: TextAlign.center,
                "Update Required"),
            SizedBox(
              height: SpacingConfigs.spacing2,
            ),
            BodyText(
                textAlign: TextAlign.center,
                "To continue using the app, you must update to the latest version. This update includes important security and bug fixes, as well as new features."),
            SizedBox(
                height: SpacingConfigs.spacing2
            ),
            BaseButton(
              onPressed: (){
                context.read<UpdateRequiredBloc>().add(LaunchUpdateLinkEvent());
              },
              child: BodyText("UPDATE", color: ColorsConfigs.white),
            )
          ],
        ),
      ),
    );
  }

  @override
  UpdateRequiredState onCreateState() {
    return UpdateRequiredState();
  }

}