import 'package:flutter/widgets.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class ErrorScreen extends StatelessWidget {
  BaseState state;

  ErrorScreen(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Error ${state.initError?.toString()}");
  }
}
