import 'package:flutter/widgets.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/widgets/containers/full_container.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

import '../../async_bloc/async_state.dart';
import '../../async_bloc/base_state.dart';

class LoadingScreen extends StatelessWidget {
  BaseState state;

  LoadingScreen(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return FullContainer(
        decoration: BoxDecoration(color: ColorsConfigs.white),
        child: PercentageContainer(
            width: 0.75,
            child: Column(
              children: [
                Image.asset("assets/images/logo.png"),
                Heading2("Loading..."),
              ],
            )));
  }
}
