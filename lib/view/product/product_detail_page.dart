import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/bloc/product_bloc.dart';
import 'package:housesolutions/model/worker.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/map.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';
import 'package:responsive_screen/responsive_screen.dart';

class ProductDetailPage extends StatefulWidget {
  int idWorker;
  int idCategory;
  ProductDetailPage(this.idWorker, this.idCategory);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<ProductBloc>();
  final orderBloc = BlocProvider.getBloc<OrderBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.workerDetail(widget.idWorker);
  }

  @override
  void dispose() { 
    bloc.setWorker(null);
    orderBloc.setRadio("m");
    orderBloc.setTotalDay(null);
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
                    child: StreamBuilder<Worker>(
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
                                            child: StreamBuilder<String>(
                                              initialData: "m",
                                              stream: orderBloc.getRadio,
                                              builder: (context, rad) {
                                                if (rad.data == "m") {
                                                  return Text(snapshot.data.workerSalary, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20));
                                                }
                                                return Text("${rupiah(snapshot.data.categoryPpSalary)}/Hari", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20));
                                              }
                                            )
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
                                        onPressed: () => navService.navigateTo("/product-more", snapshot.data),
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
                                        onPressed: () => navService.navigateTo("/product-about", snapshot.data.workerDesc),
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
                                        onPressed: () => navService.navigateTo("/product-certified", snapshot.data.workerCertificate),
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
                                        onPressed: () => navService.navigateTo("/product-other", [snapshot.data.workerPlacement, snapshot.data.workerSkills]),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.users),
                                            SizedBox(height: 5),
                                            Text("Detail Pekerja", softWrap: true, textAlign: TextAlign.center)
                                          ],
                                        )
                                      ),
                                    ),
                                    // Flexible(
                                    //   child: FlatButton(
                                    //     // onPressed: () => MapUtils.openMap(context, snapshot.data.workerLat, snapshot.data.workerLong),
                                    //     onPressed: () => showAlert(
                                    //       context: context,
                                    //       title: "Lokasi Pekerja",
                                    //       body: "Lakukan pembayaran admin untuk mengetahui lokasi pekerja!",
                                    //     ),
                                    //     child: Column(
                                    //       children: <Widget>[
                                    //         Icon(FontAwesomeIcons.locationArrow),
                                    //         SizedBox(height: 5),
                                    //         Text("Lokasi Pekerja", softWrap: true, textAlign: TextAlign.center)
                                    //       ],
                                    //     )
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Builder(
                                  builder: (_) {
                                    if (snapshot.data.workerMore.wmoreStayIn) return SizedBox();
                                    if (snapshot.data.workerOnlineRegist) return SizedBox();
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(40, 8, 40, 0),
                                      child: StreamBuilder<String>(
                                        initialData: "m",
                                        stream: orderBloc.getRadio,
                                        builder: (context, snapshot) {
                                          return Row(
                                            children: <Widget>[
                                              Radio(
                                                groupValue: snapshot.data,
                                                onChanged: orderBloc.setRadio,
                                                value: "d",
                                              ),
                                              Text("Harian", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                                              Expanded(child: SizedBox()),
                                              Radio(
                                                groupValue: snapshot.data,
                                                onChanged: orderBloc.setRadio,
                                                value: "m",
                                              ),
                                              Text("Bulanan", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                                            ],
                                          );
                                        }
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                StreamBuilder<String>(
                                  initialData: "m",
                                  stream: orderBloc.getRadio,
                                  builder: (context, radio) {
                                    if (radio.data == "m") return SizedBox();
                                    return StreamBuilder<int>(
                                      initialData: 1,
                                      stream: orderBloc.getTotalDay,
                                      builder: (context, snapshot) {
                                        return Column(
                                          children: <Widget>[
                                            Text("${snapshot.data??1} Hari"),
                                            Slider(
                                              divisions: 30,
                                              value: snapshot.data?.toDouble()??1, 
                                              onChanged: (i) => orderBloc.setTotalDay(i.toInt()),
                                              min: 1,
                                              max: 30,
                                              label: "Jumlah Hari",
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                  }
                                ),
                                SizedBox(height: 10),
                                StreamBuilder<String>(
                                  initialData: "m",
                                  stream: orderBloc.getRadio,
                                  builder: (context, radio) {
                                    return StreamBuilder<int>(
                                      stream: orderBloc.getTotalDay,
                                      builder: (context, total) {
                                        if (radio.data == "m") {
                                          if (!snapshot.data.workerOnlineRegist && !snapshot.data.workerMore.wmoreStayIn) {
                                            return Text("ADM ${rupiah(1000000)}", style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w800));
                                          } else {
                                            return Text("ADM ${rupiah(int.parse(snapshot.data.admPrice))}", style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w800));
                                          }
                                        }else {
                                            return Text("ADM ${rupiah(int.parse(snapshot.data.admPrice))}/Hari", style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w800));
                                        }
                                      }
                                    );
                                  }
                                ),
                                SizedBox(height: 10),
                                StreamBuilder<String>(
                                  initialData: "m",
                                  stream: orderBloc.getRadio,
                                  builder: (context, radio) {
                                    if (radio.data == "m") {
                                      if (!snapshot.data.workerOnlineRegist && !snapshot.data.workerMore.wmoreStayIn) {
                                        return Text("Total ${rupiah(1000000)}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800));
                                      } else {
                                        return Text("Total ${rupiah(int.parse(snapshot.data.admPrice))}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800));
                                      }
                                      
                                    }
                                    return StreamBuilder<int>(
                                      initialData: 1,
                                      stream: orderBloc.getTotalDay,
                                      builder: (context, total) {
                                        return Text("Total ${rupiah((int.parse(snapshot.data.admPrice??0) + int.parse(snapshot.data.categoryPpSalary??0)) * (total.data??1))}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800));
                                      }
                                    );
                                  }
                                ),
                                // SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.phone), 
                                      onPressed: () => showAlert(
                                        context: context,
                                        title: "Telepon Pekerja",
                                        body: "Lakukan pembayaran admin untuk dapat terhubung dengan pekerja!",
                                      )
                                    ),
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.whatsapp), 
                                      onPressed: () => showAlert(
                                        context: context,
                                        title: "Whatsapp Pekerja",
                                        body: "Lakukan pembayaran admin untuk dapat terhubung dengan pekerja!",
                                      )
                                    ),
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.commentDots), 
                                      onPressed: () => showAlert(
                                        context: context,
                                        title: "Chat Pekerja",
                                        body: "Lakukan pembayaran admin untuk dapat terhubung dengan pekerja!",
                                      )
                                    ),
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.mapMarkerAlt), 
                                      onPressed: () => showAlert(
                                        context: context,
                                        title: "Lokasi Pekerja",
                                        body: "Lakukan pembayaran admin untuk dapat melihat lokasi pekerja!",
                                      )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  color: Theme.of(context).primaryColor,
                                  colorBrightness: Brightness.dark,
                                  child: Text("Ambil Pekerja Ini"),
                                  onPressed: () => bloc.confirmOrder(widget.idCategory),
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
                                bloc.workerDetail(widget.idWorker);
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
                  child: StreamBuilder<Worker>(
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

    return Scaffold(
      key: _key,
      body: StreamBuilder<Worker>(
        stream: bloc.getWorker,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: snapshot.error,
                buttonText: allTranslations.text("TRY_AGAIN"),
                onPressed: () {
                  bloc.setWorker(null);
                  bloc.workerDetail(widget.idWorker);
                },
              ),
            );
          } return LoadingBlock();
        }
      ),
    );
  }
}