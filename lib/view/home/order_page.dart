import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:housesolutions/model/own_worker.dart';
import 'package:housesolutions/model/payment.dart';
import 'package:housesolutions/model/summary.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';
import 'package:responsive_screen/responsive_screen.dart';

class OrderPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<OrderBloc>();

  Map<String, String> status = {
    "active": allTranslations.text("ACTIVE").toUpperCase(),
    "empty": allTranslations.text("SETTLE").toUpperCase(),
    "deal": allTranslations.text("ACTIVE").toUpperCase(),
    "expired": allTranslations.text("EXPIRED").toUpperCase()
  };

  Map<String, Color> warna = {
    "active": Colors.blue,
    "deal": Colors.blue,
    "empty": Colors.yellow,
    "expired": Colors.red,
  };

  String zeroPad(int val) {
    if (val < 10) {
      return "0$val";
    }
    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text(allTranslations.text("TRANSACTION")),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<Summary>(
                stream: bloc.getSummary,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? snapshot.data.countTrans.toString() :"0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
                }
              ),
              Text(allTranslations.text("ORDERS"), style: TextStyle(fontSize: 8))
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<Summary>(
                stream: bloc.getSummary,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? snapshot.data.countWorker.toString() :"0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
                }
              ),
              Text(allTranslations.text("WORKER"), style: TextStyle(fontSize: 8))
            ],
          ),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          child: Container(
            height: 30,
            child: StreamBuilder<int>(
              initialData: 0,
              stream: bloc.getTAB,
              builder: (context, snapshot) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        highlightColor: Colors.white.withOpacity(0.1),
                        onTap: () => bloc.setTAB(0),
                        child: Container(
                          child: Center(child: Text(allTranslations.text("ORDERS"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 4, color: snapshot.data == 0 ? Colors.white:Colors.transparent))
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => bloc.setTAB(1),
                        child: Container(
                          child: Center(child: Text(allTranslations.text("MY_WORKERS"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 4, color: snapshot.data == 1 ? Colors.white:Colors.transparent))
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => bloc.setTAB(2),
                        child: Container(
                          child: Center(
                            child: Text(allTranslations.text("GUARANTEE"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 4, color: snapshot.data == 2 ? Colors.white:Colors.transparent))
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ), 
          preferredSize: Size.fromHeight(30)
        )
      ),
      body: StreamBuilder<int>(
        initialData: 0,
        stream: bloc.getTAB,
        builder: (context, snapshot) {
          if(snapshot.data == 0) {
            return StreamBuilder<List<Payment>>(
              stream: bloc.getOrders,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Stack(
                      children: <Widget>[
                        RefreshIndicator(
                          key: _refreshKey,
                          onRefresh: bloc.fetchOrders,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (ctx, i) => SizedBox(
                              width: double.infinity,
                              height: 30,
                            ),
                          ),
                        ),
                        Center(
                          child: Image.asset(R.assetsImagesBelumMemilikiTransaksi, scale: 2.0),
                        )
                      ],
                    );
                  }
                  return RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: bloc.fetchOrders,
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (ctx, i) => Divider(),
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          title: Text("#${snapshot.data[i].transId.toString().toUpperCase()}"),
                          subtitle: Text("${allTranslations.text('UPDATED')} : ${tanggal(snapshot.data[i].transUpdated)} ${zeroPad(snapshot.data[i].transUpdated.hour)}:${zeroPad(snapshot.data[i].transUpdated.minute)}"),
                          trailing: SizedBox(
                            width: wp(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Status :", style: TextStyle(fontSize: 10)),
                                Text(status[snapshot.data[i].transStatus], softWrap: true, style: TextStyle(fontWeight: FontWeight.w700, color: warna[snapshot.data[i].transStatus], fontSize: 12), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          onTap: () => navService.navigateTo("/detail-order", snapshot.data[i]),
                        );
                      },
                    ),
                  );
                } else if(snapshot.hasError) {
                  return Center(
                    child: ErrorPage(
                      message: snapshot.error,
                      buttonText: "ulangi",
                      onPressed: () {
                        bloc.setOrders(null);
                        bloc.fetchOrders();
                      },
                    ),
                  );
                } return LoadingBlock();
              }
            );
          }else if(snapshot.data == 1) {
            return StreamBuilder<List<OwnWorkers>>(
              stream: bloc.getWorkers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Stack(
                      children: <Widget>[
                        RefreshIndicator(
                          key: _refreshKey,
                          onRefresh: bloc.fetchOwnWorker,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (ctx, i) => SizedBox(
                              width: double.infinity,
                              height: 30,
                            ),
                          ),
                        ),
                        Center(
                          child: Image.asset(R.assetsImagesBelumMemilikiPekerja, scale: 2.0),
                        )
                      ],
                    );
                  }
                  return RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: bloc.fetchOwnWorker,
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (ctx, i) => Divider(),
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          onTap: () => navService.navigateTo("/myworker-detail", snapshot.data[i]),
                          leading: snapshot.data[i].workerProfile != null ? CircleAvatar(
                            backgroundImage: new CachedNetworkImageProvider(snapshot.data[i].workerProfile),
                            backgroundColor: Colors.transparent,
                            radius: 25,
                          ):CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Center(
                              child: Text("${snapshot.data[i].workerName.split(" ")[0][0]}", style: TextStyle(color: Colors.white, fontSize: 30)),
                            ),
                            radius: 25,
                          ),
                          title: Text("${snapshot.data[i].workerName}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${snapshot.data[i].categoryDesc}", style: TextStyle(fontSize: 10)),
                              Text("Gaji ${rupiah(snapshot.data[i].workerSalary)}/bulan", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Lama Kerja", style: TextStyle(fontSize: 10)),
                              Text("${DateTime.now().difference(snapshot.data[i].cworkerStart).inDays < 30 ? DateTime.now().difference(snapshot.data[i].cworkerStart).inDays : (DateTime.now().difference(snapshot.data[i].cworkerStart).inDays/30).toStringAsFixed(0)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              Text(DateTime.now().difference(snapshot.data[i].cworkerStart).inDays < 30 ? "Hari":"Bulan", style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if(snapshot.hasError) {
                  return Center(
                    child: ErrorPage(
                      message: snapshot.error,
                      buttonText: "ulangi",
                      onPressed: () {
                        bloc.setWorkers(null);
                        bloc.fetchOwnWorker();
                      },
                    ),
                  );
                } return LoadingBlock();
              }
            );
          }else if(snapshot.data == 2) {
            return StreamBuilder<Summary>(
              stream: bloc.getSummary,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.detailAttempt.length == 0) {
                    return Stack(
                      children: <Widget>[
                        RefreshIndicator(
                          key: _refreshKey,
                          onRefresh: bloc.fetchSummary,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (ctx, i) => SizedBox(
                              width: double.infinity,
                              height: 30,
                            ),
                          ),
                        ),
                        Center(
                          child: Image.asset(R.assetsImagesDataTidakTersedia, scale: 2.0),
                        )
                      ],
                    );
                  }
                  return RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: bloc.fetchSummary,
                    child: ListView.separated(
                      itemCount: snapshot.data.detailAttempt.length,
                      separatorBuilder: (ctx, i) => Divider(),
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          onTap: () => navService.navigateTo("/product-list", Categories.fromJson({"id_category": snapshot.data.detailAttempt[i].idCategory, "category_desc": snapshot.data.detailAttempt[i].categoryDesc})),
                          title: Text(snapshot.data.detailAttempt[i].categoryDesc),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Garansi", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                              Text(snapshot.data.detailAttempt[i].attempt.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                              Text("Kali", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700))
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if(snapshot.hasError) {
                  return Center(
                    child: ErrorPage(
                      message: snapshot.error,
                      buttonText: "ulangi",
                      onPressed: () {
                        bloc.setOrders(null);
                        bloc.fetchOrders();
                      },
                    ),
                  );
                } return LoadingBlock();
              }
            );
          } return Center(
            child: Text("Kesalahan index"),
          );
        }
      ),
    );
  }
}