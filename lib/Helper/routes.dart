import 'package:flutter/material.dart';
import 'package:fyp5/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../screens/Authentication/Forgot_Pass.dart';
import '../screens/Authentication/LogIn.dart';
import '../screens/Authentication/Signup.dart';
import 'auth_service.dart';


class AppRoutes {
  static const SplashRoute = "/";
  static const LoginRoute = "/Login";
  static const SignUpRoute = "/SignUp";
  static const ChangePasswordRoute = "/Cahngepass";

  static final GoRouter routes = GoRouter(routes: <GoRoute>[
    GoRoute(
      path: SplashRoute,
      builder: (BuildContext context, state) =>  SplashScreen(),
    ),
    GoRoute(
      path: LoginRoute,
      builder: (_, state) => const LoginScreen(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: SignUpRoute,
      builder: (_, state) => SignUpScreen(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: ChangePasswordRoute,
      builder: (_, state) => ForgetPassword(),
      redirect: (context, state) => _redirect(context),
    ),
  ]);

  static String? _redirect(BuildContext context) {
    return AuthService.authenticated ? null : context.namedLocation("/");
  }
}
