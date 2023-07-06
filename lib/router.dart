import 'package:go_router/go_router.dart';
import 'package:jobapp/apps/auth/presentation/screens/login_screen.dart';
import 'package:jobapp/apps/auth/presentation/screens/lowcredit_screen.dart';
import 'package:jobapp/apps/auth/presentation/screens/review_screen.dart';
import 'package:jobapp/apps/auth/presentation/screens/signup_screen.dart';
import 'package:jobapp/apps/auth/presentation/screens/update_required_screen.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/apps/core/presentation/screens/job_map_screen.dart';
import 'package:jobapp/apps/core/presentation/screens/job_session_screen.dart';
import 'package:jobapp/apps/core/presentation/screens/search_screen.dart';
import 'package:jobapp/lib/widgets/screens/authenticated_screen.dart';

import 'apps/core/presentation/screens/settings_screen.dart';
import 'apps/core/presentation/screens/splash_screen.dart';

class JobAppRouter extends GoRouter {
  JobAppRouter()
      : super(routes: [
          GoRoute(path: "/", builder: (context, state) => const SplashScreen()),
          GoRoute(
              path: "/auth/signup",
              builder: (context, state) => const SignupScreen()),
          GoRoute(
              path: "/auth/login",
              builder: (context, state) => const LoginScreen()),
          GoRoute(
              path: "/auth/review",
              builder: (context, state) => const ReviewScreen()),
          GoRoute(
              path: "/auth/low-credit",
              builder: (context, state) => const LowCreditScreen()
          ),
          GoRoute(
            path: "/auth/update-required",
            builder: (context, state) => const UpdateRequiredScreen()
          ),
          GoRoute(
              path: "/core/job-map",
              builder: (context, state) => AuthenticatedScreen(
                      child: JobMapScreen(
                    selectedJob: state.extra as Job?,
                  ))),

          GoRoute(
              path: "/core/settings",
              builder: (context, state) =>
                  AuthenticatedScreen(child: const SettingsScreen())),
          GoRoute(
            path: "/core/search",
            builder: (context, state) =>
                AuthenticatedScreen(child: const SearchScreen()),
          ),
          GoRoute(
              path: "/core/session",
              builder: (context, state) =>
                  AuthenticatedScreen(child: const JobSessionScreen())),
        ]);
}
