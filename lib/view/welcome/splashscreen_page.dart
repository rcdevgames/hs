import 'package:flutter/material.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    // var userData = await sessions.checkAuth();
    var userData = await sessions.load("lang");
    if (userData == null) sessions.save("lang", "id");

    print("Lang : $userData");
    await Future.delayed(const Duration(milliseconds: 3000));

    // Check User Session Exists
    if (userData != null) {
      navService.navigateReplaceTo("/main");
      return false;
    }

    navService.navigateReplaceTo("/welcome");
    // navService.navigateReplaceTo("/init-lang");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Center(
        child: Image.asset(
          "assets/Images/icon.png",
        ),
      ),
    );
  }
}