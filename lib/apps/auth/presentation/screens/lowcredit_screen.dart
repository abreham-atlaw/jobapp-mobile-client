


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobapp/apps/auth/application/blocs/lowcredit_bloc.dart';
import 'package:jobapp/apps/auth/application/states/lowcredit_state.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/widgets/buttons/base_button.dart';
import 'package:jobapp/lib/widgets/containers/full_container.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class LowCreditScreen extends AsyncBlocScreen<LowCreditBloc, LowCreditState>{

  const LowCreditScreen({super.key});


  @override
  LowCreditBloc onCreateBloc(LowCreditState state) {
    return LowCreditBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, LowCreditState state) {
      return FullContainer(
          child: PercentageContainer(
            width: 0.8,
            child: Column(
              children: [
                PercentageContainer(
                  width: 0.8,
                  child: Image.asset("assets/images/meter.png"),
                ),
                SizedBox(
                  height: SpacingConfigs.spacing2,
                ),
                Heading1(
                    textAlign: TextAlign.center,
                    "Your credits are running low."),
                SizedBox(
                  height: SpacingConfigs.spacing2,
                ),
                BodyText(
                    textAlign: TextAlign.center,
                    "You have ETB ${state.me!.credit} credits left. Please refill your credit to continue using the app."),
                SizedBox(
                  height: SpacingConfigs.spacing2
                ),
                BaseButton(
                  child: BodyText("REFILL", color: ColorsConfigs.white),
                )
              ],
            ),
          ),
        );
  }

  @override
  LowCreditState onCreateState() {
    return LowCreditState();
  }

}