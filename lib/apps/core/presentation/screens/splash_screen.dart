import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:jobapp/apps/auth/data/models/authentication_status.dart';
import 'package:jobapp/configs/content_configs.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/widgets/containers/full_container.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/screens/authenticated_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticatedScreen(
          validStatuses: const [],
          redirectMap: const {
            AuthenticationStatus.authenticated: "/core/job-map",
            AuthenticationStatus.review: "/auth/review",
            AuthenticationStatus.none: "/auth/login"
          },
          child: SizedBox.shrink(),
          loadingScreen: FullContainer(
              decoration: BoxDecoration(color: ColorsConfigs.white),
              child: PercentageContainer(
                  width: 0.75,
                  child: Column(
                    children: [
                      Image.asset("assets/images/logo.png"),
                      Heading1(NameConfigs.appName),
                      BodyText("Connecting talent with opportunity.")
                    ],
                  )))),
    );
  }
}
