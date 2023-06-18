import 'package:go_router/go_router.dart';
import 'package:jobapp/apps/auth/presentation/screens/login_screen.dart';
import 'package:jobapp/apps/auth/presentation/screens/signup_screen.dart';

class JobAppRouter extends GoRouter {
  JobAppRouter()
      : super(routes: [
          GoRoute(path: "/", builder: (context, state) => const LoginScreen()),
          GoRoute(
              path: "/auth/signup",
              builder: (context, state) => const SignupScreen()),
          GoRoute(
              path: "/auth/login",
              builder: (context, state) => const LoginScreen())
        ]);
}
