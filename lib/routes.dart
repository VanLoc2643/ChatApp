
import 'package:appchat/screens/login_screen.dart';
import 'package:appchat/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/',
    builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(path: '/login',
    builder: (context, state) =>  LoginScreen(),
    ),
  ]
);