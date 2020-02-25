import 'package:flutter/material.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:indonesia/indonesia.dart';
import 'package:responsive_screen/responsive_screen.dart';

class JobListPage extends StatefulWidget {
  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

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
          Flexible(
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () => null,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(Icons.location_on, size: 18, color: Theme.of(context).primaryColor),
                          Expanded(child: Text("Lokasi", style: TextStyle(color: Theme.of(context).primaryColor))),
                          Text(tanggal(DateTime.now(), shortMonth: true), style: TextStyle(color: Colors.grey))
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text("JUDUL Pekerjaan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25), softWrap: true),
                          SizedBox(height: 10),
                          Text("Pekerja yang berminat : ${0} Orang", style: TextStyle(color: Colors.grey, fontSize: 12))
                        ],
                      ),
                    ),
                  ),
                ) 
              ), 
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navService.navigateTo("/job-form"), 
        label: Text("Request Pekerja", style: TextStyle(color: Colors.white))
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}