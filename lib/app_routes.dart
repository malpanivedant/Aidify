import 'package:flutter/material.dart';
import 'package:help_on_needs/authentication/login/login_page.dart';
import 'package:help_on_needs/authentication/register/register_page.dart';
import 'package:help_on_needs/form/form_page.dart';
import 'package:help_on_needs/landing_page/landing_page.dart';
import 'package:help_on_needs/profile/profile_page.dart';

import 'disaster_detail/disaster_detail_page.dart';

class AppRoutes {
  // Route name constants
  static const String landingPage = '/landingPage';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String profilePage = '/profilePage';
  static const String disasterDetailPage = '/disasterDetailPage';
  static const String formPage = '/formPage';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      landingPage: (context) => const LandingPage(),
      loginPage: (context) => const LoginPage(),
      registerPage: (context) => const RegisterPage(),
      profilePage: (context) => const ProfilePage(),
      disasterDetailPage: (context) => const DisasterDetailPage(),
      formPage: (context) => const FormPage(),
    };
  }
}
