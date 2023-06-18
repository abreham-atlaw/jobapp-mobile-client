import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobapp/apps/auth/application/events/login_event.dart';
import 'package:jobapp/apps/auth/application/blocs/login_bloc.dart';
import 'package:jobapp/apps/auth/application/states/login_state.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/widgets/buttons/async_button.dart';
import 'package:jobapp/lib/widgets/containers/full_container.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/forms/labeled_field.dart';
import 'package:jobapp/lib/widgets/forms/text_field_widget.dart';
import 'package:jobapp/lib/widgets/navigation/link.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/errors.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class LoginScreen extends AsyncBlocScreen<LoginBloc, LoginState> {
  const LoginScreen({super.key});

  @override
  LoginBloc onCreateBloc(LoginState state) {
    return LoginBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, LoginState state) {
    return FullContainer(
      alignment: Alignment.center,
      child: PercentageContainer(
        width: 0.8,
        child: Column(
          children: [
            Heading1("Welcome Back"),
            BodyText("Login to continue your work journey"),
            SizedBox(
              height: SpacingConfigs.spacing3,
            ),
            ErrorText(state.error?.message ?? ""),
            SizedBox(
              height: SpacingConfigs.spacing2,
            ),
            LabeledFormField(
              label: "Phone Number",
              inputField: TextFieldWidget(
                field: state.form.username,
                iconData: Icons.phone_android,
              ),
            ),
            SizedBox(
              height: SpacingConfigs.spacing3,
            ),
            LabeledFormField(
              label: "Password",
              inputField: TextFieldWidget(
                field: state.form.password,
                iconData: Icons.lock,
                obsecureText: true,
              ),
            ),
            SizedBox(
              height: SpacingConfigs.spacing4,
            ),
            AsyncButton(
              onPressed: () => {context.read<LoginBloc>().add(LoginEvent())},
              label: "Login",
              state: state,
            ),
            SizedBox(
              height: SpacingConfigs.spacing3,
            ),
            Align(
              alignment: Alignment.center,
              child: Wrap(
                children: [
                  BodyText("Dont't Have an Account? "),
                  Link(
                    to: "/auth/signup",
                    child: BodyText(
                      "Signup",
                      color: ColorsConfigs.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  LoginState onCreateState() {
    return LoginState();
  }
}
