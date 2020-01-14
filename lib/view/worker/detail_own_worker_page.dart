import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:housesolutions/model/own_worker.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:responsive_screen/responsive_screen.dart';

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

  Widget profileData(context, {String key, String value, bool valueBold = false}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(key, style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(":")
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(flex:2, child: Text(value??"-", style: TextStyle(fontWeight: valueBold ? FontWeight.w700:FontWeight.normal), softWrap: true,)),
            ],
          ),
        ),
        Divider(color: Theme.of(context).primaryColor)
      ],
    );
  }

  Widget profileDataBig(context, {String key, String value}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(key, style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(":")
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(flex:2, child: Text("")),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: value != null ? Html(data: value):Text(""),
        ),
        Divider(color: Theme.of(context).primaryColor)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Detail ${widget.data.workerName}"),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
      ),
      body: StreamBuilder<MyWorker>(
        stream: bloc.getWorker,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF98866)
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 140,
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data.workerProfile,
                              fit: BoxFit.fitHeight,
                              placeholder: (ctx, i) => Center(
                                child: LoadingBlock(Colors.white),
                              ),
                              errorWidget: (ctx, i, obj) => Center(
                                child: Text("Error Show Profile Picture\nScrolldown to refresh", style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Nama Lengkap : ", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                                Text(snapshot.data.workerName, style: TextStyle(color: Colors.white)),
                                SizedBox(height: 5),
                                Text("Usia : ", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                                Text("${snapshot.data.workerAge} Tahun", style: TextStyle(color: Colors.white)),
                                SizedBox(height: 5),
                                Text("Asal : ", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                                Text(snapshot.data.districtName, style: TextStyle(color: Colors.white)),
                                SizedBox(height: 5),
                                Text("Gaji : ", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    color: Color(0xFFF98866),
                    child: Center(
                      child: RatingBarIndicator(
                        rating: double.parse(snapshot.data.workerRating),
                        itemSize: 20,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text("Detail Pekerja"),
                    children: <Widget>[
                      profileData(context, key: "Nama Lengkap", value: snapshot.data.workerName),
                      profileData(context, key: "Usia", value: "${snapshot.data.workerAge} Tahun"),
                      profileData(context, key: "Pekerjaan", value: snapshot.data.categoryDesc),
                      profileData(context, key: "Menginap", value: snapshot.data.workerMore.wmoreStayIn ? "Bisa Menginap":"Pulang Pergi"),
                      profileData(context, key: "Status", value: snapshot.data.workerMore.wmoreStatus),
                      profileData(context, key: "Anak", value: "${snapshot.data.workerMore.wmoreChildren??0} Anak"),
                      profileData(context, key: "Tinggi Badan", value: snapshot.data.workerHeight),
                      profileData(context, key: "Berat Badan", value: snapshot.data.workerWeight),
                      profileData(context, key: "Kota/Kabupaten", value: snapshot.data.districtName),
                      profileData(context, key: "Provinsi", value: snapshot.data.provinceName),
                      profileData(context, key: "Kerja Luar Negeri", value: snapshot.data.workerMore.wmoreAbroadEx != null && snapshot.data.workerMore.wmoreAbroadEx ? "Berpengalaman":"Tidak Berpengalaman"),
                      profileData(context, key: "Bahasa", value: snapshot.data.workerMore.wmoreLanguage),
                      profileData(context, key: "Phobia", value: snapshot.data.workerMore.wmorePhobia),
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Tentang Pekerja"),
                    children: <Widget>[
                      profileDataBig(context, key: "Tentang Pekerja", value: snapshot.data.workerDesc)
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Sertifikat"),
                    children: snapshot.data.workerCertificate.length > 0 ? snapshot.data.workerCertificate.map((certificate) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(certificate.certificateTitle.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: certificate.certificateImage,
                                    placeholder: (ctx, i) => Center(child: LoadingBlock(Theme.of(context).primaryColor)),
                                    errorWidget: (ctx, i, a) => Center(child: Text(i)),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList():[Center(child: Text("Tidak memiliki sertifikat"))],
                  ),
                  ExpansionTile(
                    title: Text("Informasi Lainnya"),
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
                                snapshot.data.workerPlacement.length > 0 ? Column(
                                  children: snapshot.data.workerPlacement.map((skill) {
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
                                snapshot.data.workerSkills.length > 0 ? Column(
                                  children: snapshot.data.workerSkills.map((skill) {
                                    return Row(
                                      children: <Widget>[
                                        Icon(Icons.check_box, color: Theme.of(context).primaryColor),
                                        SizedBox(width: 5),
                                        SizedBox(
                                          width: wp(80),
                                          child: Text(skill, softWrap: true)
                                        )
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
                ],
              ),
            );
          } else if(snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: snapshot.error,
                buttonText: allTranslations.text("TRYAGAIN"),
                onPressed: () {
                  bloc.setWorker(null);
                  bloc.loadWorker(widget.data.idCworker);
                },
              ),
            );
          } return LoadingBlock();
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navService.navigateTo("/change-worker"),
        icon: Icon(Icons.refresh, color: Colors.white),
        label: Text("Saya ingin tukar pekerja ini", style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}