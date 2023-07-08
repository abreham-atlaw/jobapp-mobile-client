import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/auth/application/blocs/signup_bloc.dart';
import 'package:jobapp/apps/auth/application/events/signup_event.dart';
import 'package:jobapp/apps/auth/application/states/signup_state.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/async_bloc/async_status.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/widgets/buttons/async_button.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/forms/labeled_field.dart';
import 'package:jobapp/lib/widgets/forms/text_field_widget.dart';
import 'package:jobapp/lib/widgets/navigation/link.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/errors.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class SignupScreen extends AsyncBlocScreen<SignupBloc, SignupState> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  SignupBloc onCreateBloc(SignupState state) {
    return SignupBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, SignupState state) {
    if (state.asyncStatus == AsyncStatus.done) {
      RoutingUitls.redirect("/", context);
    }
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SpacingConfigs.spacing5),
        alignment: Alignment.center,
        child: PercentageContainer(
          width: 0.8,
          child: Column(
            children: [
              Heading1("Let's Get Started"),
              BodyText("Create an account and start working now"),
              SizedBox(
                height: SpacingConfigs.spacing3,
              ),
              ErrorText(state.error?.message ?? ""),
              SizedBox(
                height: SpacingConfigs.spacing2,
              ),
              LabeledFormField(
                label: "Full Name",
                inputField: TextFieldWidget(
                  field: state.form.fullName,
                  iconData: Icons.person,
                ),
              ),
              SizedBox(
                height: SpacingConfigs.spacing3,
              ),
              LabeledFormField(
                label: "Phone Number",
                inputField: TextFieldWidget(
                  field: state.form.phoneNumber,
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
                height: SpacingConfigs.spacing3,
              ),
              LabeledFormField(
                label: "Confirm Password",
                inputField: TextFieldWidget(
                  field: state.form.confirmPassword,
                  iconData: Icons.lock,
                  obsecureText: true,
                ),
              ),
              SizedBox(
                height: SpacingConfigs.spacing4,
              ),
              AsyncButton(
                onPressed: () =>
                    {context.read<SignupBloc>().add(SignupEvent())},
                label: "Create Account",
                state: state,
              ),
              SizedBox(
                height: SpacingConfigs.spacing3,
              ),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    BodyText("Already have an account? "),
                    Link(
                      to: "/auth/login",
                      child: BodyText(
                        "Sign in",
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
      ),
    );
  }

  @override
  SignupState onCreateState() {
    return SignupState();
  }
}
