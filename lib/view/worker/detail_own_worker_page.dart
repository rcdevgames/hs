import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:housesolutions/model/own_worker.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/map.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailOwnWorkerPage extends StatefulWidget {
  OwnWorkers data;
  DetailOwnWorkerPage(this.data);

  @override
  _DetailOwnWorkerPageState createState() => _DetailOwnWorkerPageState();
}

class _DetailOwnWorkerPageState extends State<DetailOwnWorkerPage> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<OrderBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.loadWorker(widget.data.idCworker);
  }

  @override
  void dispose() {
    bloc.setWorker(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      backgroundColor: Colors.red,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: hp(18),
                    child: Arc(
                      height: 35,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(R.assetsImagesBackground),
                            fit: BoxFit.fitWidth
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Flexible(
                child: Arc(
                  edge: Edge.TOP,
                  height: 30,
                  child: Container(
                    width: wp(100),
                    height: hp(100),
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
                    color: Colors.white,
                    child: StreamBuilder<MyWorker>(
                      stream: bloc.getWorker,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text(snapshot.data.workerName),
                                Text("${snapshot.data.districtName} || ${snapshot.data.workerAge} Tahun"),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(child: Text("GAJI", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600))),
                                          TableCell(child: Text("PENILAIAN", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600))),
                                        ]
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Builder(
                                              builder: (context) {
                                                if (snapshot.data.onlineRegist??false) {
                                                  return Text(rupiah(1500000), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20));
                                                }else {
                                                  if (snapshot.data.workerMore.wmoreStayIn) {
                                                    return Text("${rupiah(snapshot.data.workerSalary)}/Bulan", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20));
                                                  }else{
                                                    return Text("${rupiah(snapshot.data.workerSalaryDaily??0)}/Hari\n3 Hari : ${rupiah(int.parse(snapshot.data.workerSalaryDaily??'0') * (snapshot.data.totalDay??0))}", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20));
                                                  }
                                                }
                                              }
                                            ),
                                            // Text(rupiah(snapshot.data.workerSalary), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20))
                                          ),
                                          TableCell(child: Column(
                                            children: <Widget>[
                                              RatingBarIndicator(
                                                rating: double.parse(snapshot.data.workerRating),
                                                itemSize: 15,
                                                itemCount: 5,
                                                itemBuilder: (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                ),
                                              ),
                                              Text((double.parse(snapshot.data.workerRating)).toString(), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18))
                                            ],
                                          )),
                                        ]
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: FlatButton(
                                        onPressed: () => navService.navigateTo("/worker-more", snapshot.data),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.fileAlt),
                                            SizedBox(height: 5),
                                            Text("Data Pekerja", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                    Flexible(
                                      child: FlatButton(
                                        onPressed: () => navService.navigateTo("/worker-about", snapshot.data.workerDesc),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.fileSignature),
                                            SizedBox(height: 5),
                                            Text("Tentang Pekerja", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                    Flexible(
                                      child: FlatButton(
                                        onPressed: () => navService.navigateTo("/worker-certified", snapshot.data.workerCertificate),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.clipboard),
                                            SizedBox(height: 5),
                                            Text("Dokumen", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                    Flexible(
                                      child: FlatButton(
                                        onPressed: () => navService.navigateTo("/worker-other", [snapshot.data.workerPlacement, snapshot.data.workerSkills]),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.users),
                                            SizedBox(height: 5),
                                            Text("Detail Pekerja", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: FlatButton(
                                        onPressed: () async {
                                          String url = "tel:${snapshot.data.workerHandphone}";
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw "Could not lauch $url";
                                          }
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.phone),
                                            SizedBox(height: 5),
                                            Text("Telepon", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                    Flexible(
                                      child: FlatButton(
                                        onPressed: () async {
                                          String url = "https://wa.me/62${snapshot.data.workerHandphone.toString().replaceAll("Exception: ", "").substring(1, snapshot.data.workerHandphone.toString().replaceAll("Exception: ", "").length)}";
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw "Could not lauch $url";
                                          }
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.whatsapp),
                                            SizedBox(height: 5),
                                            Text("Whatsapp", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                    Flexible(
                                      child: FlatButton(
                                        onPressed: () => showAlert(
                                          context: context,
                                          title: "Chat Pekerja",
                                          body: "Mohon maaf untuk sementara fitur ini belum dapat digunakan."
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.commentDots),
                                            SizedBox(height: 5),
                                            Text("Chat", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                    Flexible(
                                      child: FlatButton(
                                        onPressed: () => MapUtils.openMap(context, snapshot.data.workerLat, snapshot.data.workerLong),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.mapMarkerAlt),
                                            SizedBox(height: 5),
                                            Text("Lokasi", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  colorBrightness: Brightness.dark,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                      child: Text("Tukar Pekerja Ini", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                                    ),
                                  ),
                                  onPressed: snapshot.data.onlineRegist == true || (snapshot.data.totalDay > 0 && snapshot.data.wmoreStayIn == false) ? null : () => navService.navigateTo("/change-worker"),
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: ErrorPage(
                              message: snapshot.error,
                              buttonText: allTranslations.text("TRY_AGAIN"),
                              onPressed: () {
                                bloc.setWorker(null);
                                bloc.loadWorker(widget.data.idCworker);
                              },
                            ),
                          );
                        } return LoadingBlock();
                      }
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 50,
            width: wp(100),
            child: Center(
              child: SizedBox(
                height: 130,
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: StreamBuilder<MyWorker>(
                    stream: bloc.getWorker,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          color: Theme.of(context).primaryColor,
                          child: snapshot.data.workerProfile == null ? 
                          Builder(
                            builder: (context) {
                              var split_name = snapshot.data.workerName?.split(" ");
                              var name = "";
                              if (split_name != null && split_name.length > 0) {
                                name = "${split_name[0][0].toUpperCase()}${split_name.length > 1 ? split_name[1][0].toUpperCase():''}";
                              }
                              return Center(child: Text(name, style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center));
                            },
                          ) : CachedNetworkImage(
                            imageUrl: snapshot.data.workerProfile,
                            fit: BoxFit.cover,
                            placeholder: (ctx, i) => Center(
                              child: LoadingBlock(Colors.white),
                            ),
                            errorWidget: (ctx, i, obj) => Center(
                              child: Text("Error Show Profile Picture\nScrolldown to refresh", style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                            ),
                          ),
                        );
                      } return Container(
                        color: Theme.of(context).primaryColor,
                        child: LoadingBlock(Colors.white)
                      );
                    }
                  ),
                ),
              ),
            )
          ),
          Positioned(
            top: 35,
            left: 10,
            child: SizedBox(
              height: 25,
              child: RaisedButton(
                color: Colors.green,
                colorBrightness: Brightness.dark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text("< Kembali"),
                onPressed: navService.navigatePop
              ),
            )
          )
        ],
      ),
    );
  }
}