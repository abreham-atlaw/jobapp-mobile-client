import 'package:flutter/widgets.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/widgets/buttons/base_button.dart';
import 'package:jobapp/lib/widgets/containers/full_container.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/navigation/link.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class ErrorScreen extends StatelessWidget {
  BaseState state;

  ErrorScreen(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return FullContainer(
        decoration: BoxDecoration(color: ColorsConfigs.white),
        child: PercentageContainer(
            width: 0.75,
            child: Column(
              children: [
                Image.asset("assets/images/error.png"),
                Heading2("Sorry, An Error has Occurred"),
                BodyText(state.initError.toString()),
                SizedBox(
                  height: SpacingConfigs.spacing2,
                ),
                BaseButton(
                  onPressed: () {
                    RoutingUitls.redirect("/", context);
                  },
                  child: BodyText(
                    "Go to Home",
                    color: ColorsConfigs.white,
                  ),
                )
              ],
            )));
  }
}
