import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/model/payment.dart';
import 'package:housesolutions/model/payment_detail.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/zero_pad.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends StatefulWidget {
  Payment payment;
  OrderDetailPage(this.payment); 

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<OrderBloc>();

  Map<String, String> status = {
    "active": "Menunggu Pembayaran",
    "empty": "Menunggu Pergantian Pekerja",
    "deal": "Aktif",
    "expired": "Kadaluarsa"
  };

  Map<String, Color> warna = {
    "active": Colors.blue,
    "deal": Colors.green,
    "empty": Colors.yellow,
    "expired": Colors.red,
  };

  @override
  void initState() { 
    super.initState();
    bloc.fetchPayment(widget.payment.idTrans);
  }

  @override
  void dispose() { 
    bloc.setPaymentDetail(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text(allTranslations.text("DETAIL_TRANSACTION")),
      ),
      body: StreamBuilder<PaymentDetail>(
        stream: bloc.getPaymentDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Status", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800, fontSize: 18)),
                          SizedBox(height: 5),
                          Text(status[snapshot.data.transStatus], style: TextStyle(color: warna[snapshot.data.transStatus], fontWeight: FontWeight.bold, fontSize: 22)),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Tanggal Transaksi", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800, fontSize: 18)),
                              Text("${snapshot.data.transCreated} WIB", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Nomor Transaksi", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800, fontSize: 18)),
                              Text(snapshot.data.transId.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  snapshot.data.transStatus == 'expired' ? SizedBox() : Builder(
                    builder: (_) => Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25,10),
                          child: Text("Detail Pekerja", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black54)),
                        ),
                      ]..addAll(snapshot.data.detail.map((worker) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 100,
                                        width: 80,
                                        child: CachedNetworkImage(imageUrl: worker.workerProfile),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          Text(worker.workerName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                          Text("${worker.workerAge} ${allTranslations.text('YEARSOLD')}", style: TextStyle(fontWeight: FontWeight.w700)),
                                          Text(worker.districtName, style: TextStyle(fontWeight: FontWeight.w700)),
                                          SizedBox(height: 8),
                                          Builder(
                                            builder: (_) {
                                              if (snapshot.data.transTotalDay != null && int.parse(snapshot.data.transTotalDay) > 0) {
                                                return Text("Gaji Harian : ${rupiah(100000)}", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor));
                                              }
                                              return Text("Gaji : ${rupiah(worker.workerSalary)}", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor));
                                            }
                                          ),
                                          Builder(
                                            builder: (_) {
                                              if (snapshot.data.transStatus == "deal" && worker.tworkerStatus == "active") {
                                                return Column(
                                                  children: <Widget>[
                                                    SizedBox(height: 8),
                                                    Text("Hubungi Pekerja via : "),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(Icons.message),
                                                          onPressed: () async {
                                                            String url = "sms:${worker.workerHandphone}";
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              throw "Could not lauch $url";
                                                            }
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Icon(Icons.call),
                                                          onPressed: () async {
                                                            String url = "tel:${worker.workerHandphone}";
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              throw "Could not lauch $url";
                                                            }
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.whatsapp),
                                                          onPressed: () async {
                                                            String url = "https://wa.me/62${worker.workerHandphone.toString().replaceAll("Exception: ", "").substring(1, worker.workerHandphone.toString().replaceAll("Exception: ", "").length)}";
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              throw "Could not lauch $url";
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              } return SizedBox();
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Informasi Pembayaran", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black54)),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Metode Pembayaran", style: TextStyle(fontSize: 17, color: Colors.grey)),
                              Text(snapshot.data.transPaymentMethod == "midtrans" ? "Credit Card/Gopay":"Transfer Bank", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Divider(height: 25),
                          Builder(
                            builder: (_) {
                              if(snapshot.data.transTotalDay != null && int.parse(snapshot.data.transTotalDay) > 0) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Total Hari", style: TextStyle(fontSize: 17, color: Colors.grey)),
                                        Text("${snapshot.data.transTotalDay} hari", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    Divider(height: 25),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Total gaji", style: TextStyle(fontSize: 17, color: Colors.grey)),
                                        Text(rupiah((100000*int.parse(snapshot.data.transTotalDay))), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    Divider(height: 25),
                                  ],
                                );
                              } return SizedBox();
                            },
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Administrasi", style: TextStyle(fontSize: 17, color: Colors.grey)),
                              Builder(
                                builder: (_) {
                                  if (!snapshot.data.detail[0].workerOnlineRegist && !snapshot.data.detail[0].wmoreStayIn) {
                                    if (snapshot.data.transTotalDay != null && int.parse(snapshot.data.transTotalDay) > 0) {
                                      return Text("(@${rupiah(snapshot.data.transAdmPrice)}) ${rupiah(int.parse(snapshot.data.transAdmPrice)*int.parse(snapshot.data.transTotalDay))}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600));
                                    }
                                    return Text(rupiah(1000000), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600));
                                  }
                                  return Text(rupiah(snapshot.data.transAdmPrice), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600));
                                }
                              ),
                            ],
                          ),
                          Divider(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total Pembayaran", style: TextStyle(fontSize: 17, color: Colors.grey)),
                              Builder(
                                builder: (_) {
                                  if (!snapshot.data.detail[0].workerOnlineRegist && !snapshot.data.detail[0].wmoreStayIn) {
                                    if (snapshot.data.transTotalDay != null && int.parse(snapshot.data.transTotalDay) > 0) {
                                      return Text(rupiah((int.parse(snapshot.data.transAdmPrice) + 100000) * int.parse(snapshot.data.transTotalDay)), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor));
                                    }
                                    return Text(rupiah(1000000), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor));
                                  }
                                  return Text(rupiah(snapshot.data.transAdmPrice), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor));
                                }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  snapshot.data.transStatus == "active" ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 10, 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        colorBrightness: Brightness.dark,
                        onPressed: () => snapshot.data.transPaymentMethod == "tf" ? navService.navigateTo("/dopay-manual", [snapshot.data.idTrans, !snapshot.data.detail[0].workerOnlineRegist && !snapshot.data.detail[0].wmoreStayIn ? (snapshot.data.transTotalDay != null && int.parse(snapshot.data.transTotalDay) > 0 ? (int.parse(snapshot.data.transAdmPrice) + 100000) * int.parse(snapshot.data.transTotalDay) : 1000000) : int.parse(snapshot.data.transAdmPrice)]) : bloc.payMidtrans(!snapshot.data.detail[0].workerOnlineRegist && !snapshot.data.detail[0].wmoreStayIn ? (snapshot.data.transTotalDay != null && int.parse(snapshot.data.transTotalDay) > 0 ? (int.parse(snapshot.data.transAdmPrice) + 100000) * int.parse(snapshot.data.transTotalDay) : 1000000) : int.parse(snapshot.data.transAdmPrice), snapshot.data.idTrans.toString()),
                        child: Text("Lakukan Pembayaran", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ):SizedBox(),
                  snapshot.data.transStatus == "deal" ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 10, 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        colorBrightness: Brightness.dark,
                        onPressed: () => navService.navigateTo("/invoice", [snapshot.data.transId, snapshot.data.invoice]),
                        child: Text("Tanda Terima Pembayaran", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ):SizedBox(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 10, 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () => navService.navigateTo("/contact-us"),
                        child: Text("Bantuan?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
                      ),
                    ),
                  )
                ],
              ),
            );
          }else if(snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: snapshot.error,
                buttonText: "ulangi",
                onPressed: () {
                  bloc.setPaymentDetail(null);
                  bloc.fetchPayment(widget.payment.idTrans);
                },
              ),
            );
          } return LoadingBlock();
        }
      ),
    );
  }
}