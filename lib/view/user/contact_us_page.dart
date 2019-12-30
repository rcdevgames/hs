import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    Widget address(String title, String address, String urls, String telepon, String handphone) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(address, style: TextStyle()),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.map, color: Colors.white),
              label: Text("Buka Google Map", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                if (await canLaunch(urls)) {
                  await launch(urls);
                } else {
                  throw "Could not lauch $urls";
                }
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton.icon(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: Text("Telepon", style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    String url = "tel:${telepon}";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw "Could not lauch $url";
                    }
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: RaisedButton.icon(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
                  label: Text("Whatsapp", style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    String url = "https://wa.me/62${handphone.substring(1, handphone.length)}";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw "Could not lauch $url";
                    }
                  },
                ),
              )
            ],
          ),
        ],
      );
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text("Hubungi Kami"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "assets/Images/icon.png",
                  scale: 2,
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/Images/logo.png",
                  width: wp(50),
                ),
              ),
              SizedBox(height: 30),
              address("House Solutions Training Center Jakarta", "Jl. Raya Pd. Gede No.12A, RT.3/RW.1, Dukuh, Kec. Kramat jati, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13550", "https://www.google.com/maps?ll=-6.288474,106.875896&z=16&t=m&hl=en&gl=ID&mapclient=embed&cid=11966702657786029657", "02122320588", "08111777395"),
              SizedBox(height: 10),
              address("House Solutions Training Center Bekasi", "Jl. Ir. H. Juanda No.110c, Duren Jaya, Kec. Bekasi Timur., Kota Bks, Jawa Barat 17113", "https://goo.gl/maps/7GE8mfoPCZ5zTas98", "02122320588", "081617775009")
            ],
          ),
        ),
      ),
    );
  }
}