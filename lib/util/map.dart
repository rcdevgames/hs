import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {

  MapUtils._();

  static Future<void> openMap(BuildContext context, String latitude, String longitude) async {
    if (latitude == null || longitude == null) {
      return showAlert(
        context: context,
        title: "Tidak dapat membuka GPS",
        body: "Pekerja tidak mengaktifkan GPSnya!"
      );
    }

    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      showAlert(
        context: context,
        title: "Tidak dapat membuka GPS",
        body: "Pekerja tidak mengaktifkan GPSnya!"
      );
    }
  }
}