import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:package_info/package_info.dart';

class UserSettingsPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  Widget menuProfile(context, {IconData icon, String title, String subtitle, void Function() onTap, Widget trailling}) {
    trailling = trailling != null ? trailling : Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor);
    return Column(
      children: <Widget>[
        ListTile(
          leading: icon != null ? Icon(icon):null,
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle):null,
          trailing: trailling,
          onTap: onTap,
        ),
        Divider(color: Theme.of(context).primaryColor)
      ],
    );
  }

  void about(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

     showAlert(
       context: context,
       title: allTranslations.text("ABOUT_APPS"),
       body: "House Solutions © 2019\nPT Malau Solutions Indonesia\n\nv${packageInfo.version}",
       barrierDismissible: true
     );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text("Setting Menu"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          menuProfile(context,
            icon: FontAwesomeIcons.language,
            title: allTranslations.text("CHANGE_LANG"),
            onTap: () => navService.navigateTo("/change-lang")
          ),
          // menuProfile(context,
          //   icon: FontAwesomeIcons.headphonesAlt,
          //   title: "Pengaduan",
          //   onTap: () => navService.navigateTo("/complaint")
          // ),
          menuProfile(context,
            icon: Icons.add_call,
            title: "Hubungi Kami",
            onTap: () => navService.navigateTo("/contact-us")
          ),
          menuProfile(context,
            icon: FontAwesomeIcons.userLock,
            title: allTranslations.text("CHANGE_PASSWORD"),
            onTap: () => navService.navigateTo("/change-password")
          ),
          menuProfile(context,
            icon: FontAwesomeIcons.fileContract,
            title: allTranslations.text("AGREEMENT_BUTTON"),
            onTap: () => navService.navigateTo("/agreement-page")
          ),
          menuProfile(context,
            icon: FontAwesomeIcons.info,
            title: allTranslations.text("ABOUT_APPS"),
            onTap: () => about(context)
          ),
        ],
      ),
    );
  }
}