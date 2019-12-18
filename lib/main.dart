import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:housesolutions/blocs.dart';
import 'package:housesolutions/routes.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';
import 'package:housesolutions/view/welcome/splashscreen_page.dart';

void main() async {
  // Load language local
  await allTranslations.init(await sessions.load("lang"));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Firebase Notification
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  // Local Notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  // Custom Material Color
  final Map<int, Color> colorMap = {
    50: Color(0xFFFEF1ED),
    100: Color(0xFFFDDBD1),
    200: Color(0xFFFCC4B3),
    300: Color(0xFFFBAC94),
    400: Color(0xFFFA9A7D),
    500: Color(0xFFF98866),
    600: Color(0xFFF8805E),
    700: Color(0xFFF77553),
    800: Color(0xFFF66B49),
    900: Color(0xFFF55838),
  };

  @override
  void initState() {
    super.initState();
    registerNotification();
    configLocalNotification();
  }

  void registerNotification() async {
    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      showNotification(message['notification']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      sessions.save("fcm", token);
    }).catchError((err) {
      print(err.message.toString().replaceAll("Exception: ", ""));
    });
  }

   Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print(data.toString());
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print(notification.toString());
    }

    // Or do other work.
  }

  void configLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'id.app.housesolutions',
      'House Solutions',
      'Mudah Cepat dan Praktis',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(1, message['title'].toString(), message['body'].toString(), platformChannelSpecifics, payload: jsonEncode(message));
  }
  
  @override
  Widget build(BuildContext context) {
    // Custom Material Color
    MaterialColor customColor = MaterialColor(0xFFF98866, colorMap);
    
    //Status Bar Color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFc2593b),
    ));

    return BlocProvider(
      blocs: blocs,
      child: MaterialApp(
        title: 'House Solutions',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryTextTheme: Typography().white,
          primaryIconTheme: IconThemeData(color: Colors.white)
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: allTranslations.supportedLocales(),
        navigatorKey: navService.navigatorKey,
        onGenerateRoute: Routes.generateRoute,
        home: new SplashScreen(),
      ),
    );
  }
}