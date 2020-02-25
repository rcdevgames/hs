import 'package:flutter/material.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/nav_service.dart';

class JobDetailPage extends StatefulWidget {
  
  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        children: <Widget>[
          Container(
            height: 140.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "Daftar Request Pekerja",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(R.assetsImagesHeader), fit: BoxFit.fitWidth)
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 5,
                  child: IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: navService.navigatePop
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}