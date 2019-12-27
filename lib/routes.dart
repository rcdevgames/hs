import 'package:flutter/material.dart';
import 'package:housesolutions/view/auth/forgot_password_page.dart';
import 'package:housesolutions/view/auth/login_page.dart';
import 'package:housesolutions/view/auth/register_page.dart';
import 'package:housesolutions/view/auth/term_and_conditions_page.dart';
import 'package:housesolutions/view/home/layout.dart';
import 'package:housesolutions/view/welcome/select_lang_page.dart';
import 'package:housesolutions/view/welcome/welcome_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Initialize Page
      case "/init-lang": return MaterialPageRoute(builder: (_) => SelectLangPage());
      case "/welcome": return MaterialPageRoute(builder: (_) => WelcomePage());
      
      // Auth Page
      case "/login": return MaterialPageRoute(builder: (_) => LoginPage());
      case "/register": return MaterialPageRoute(builder: (_) => RegisterPage());
      case "/tnc": return MaterialPageRoute(builder: (_) => TermsAndConditionPage());
      case "/forgot-password": return MaterialPageRoute(builder: (_) => ForgotPasswordPage());

      // Main Page
      case "/main": return MaterialPageRoute(builder: (_) => LayoutPage());

      // Product Page

      // Order Page

      // UserPage

        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}')
            )
          )
        );
    }
  }
}