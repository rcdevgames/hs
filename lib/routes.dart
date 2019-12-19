import 'package:flutter/material.dart';
import 'package:housesolutions/view/home/layout.dart';
import 'package:housesolutions/view/welcome/select_lang_page.dart';
import 'package:housesolutions/view/welcome/welcome_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/init-lang": return MaterialPageRoute(builder: (_) => SelectLangPage());
      case "/welcome": return MaterialPageRoute(builder: (_) => WelcomePage());
      case "/main": return MaterialPageRoute(builder: (_) => LayoutPage());
        
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