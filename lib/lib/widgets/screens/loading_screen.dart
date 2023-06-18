import 'package:flutter/widgets.dart';

import '../../async_bloc/async_state.dart';
import '../../async_bloc/base_state.dart';

class LoadingScreen extends StatelessWidget {
  BaseState state;

  LoadingScreen(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("loading");
  }
}
