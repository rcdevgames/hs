import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

class WorkerOtherPage extends StatelessWidget {
  List<String> placement;
  List<String> skill;
  WorkerOtherPage(this.placement, this.skill);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Informasi Lainnya"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(12, 10, 12, 6),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Bersedia Ditempatkan", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      placement.length > 0 ? Column(
                        children: placement.map((skill) {
                          return Row(
                            children: <Widget>[
                              Icon(Icons.check_box, color: Theme.of(context).primaryColor),
                              SizedBox(width: 5),
                              Text(skill, softWrap: true)
                            ],
                          );
                        }).toList(),
                      ):Center(child: Text("Tidak bersedia ditempatkan dimanapun"))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.fromLTRB(12, 10, 12, 6),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Kemampuan", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      skill.length > 0 ? Column(
                        children: skill.map((skill) {
                          return Row(
                            children: <Widget>[
                              Icon(Icons.check_box, color: Theme.of(context).primaryColor),
                              SizedBox(width: 5),
                              Flexible(child: Text(skill, softWrap: true))
                            ],
                          );
                        }).toList(),
                      ):Center(child: Text("Tidak memiliki kemampuan apapun"))
                    ],
                  ),
                ),
              ),
            )
          ],  
        ),
      ),
    );
  }
}