import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/model/worker.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:indonesia/indonesia.dart';

class ConfirmationOrder extends StatefulWidget {
  int idCategory;
  Worker data;
  ConfirmationOrder(this.idCategory, this.data);

  @override
  _ConfirmationOrderState createState() => _ConfirmationOrderState();
}

class _ConfirmationOrderState extends State<ConfirmationOrder> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<OrderBloc>();

  @override
  void dispose() { 
    bloc.setRadio("m");
    bloc.setTotalDay(null);
    bloc.setPaymentMethod(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text(allTranslations.text("CONFIRMATION_TRANSACTION")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Builder(
              builder: (_) {
                if (widget.data.workerMore.wmoreStayIn) return SizedBox();
                if (widget.data.workerOnlineRegist) return SizedBox();
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<String>(
                        initialData: "m",
                        stream: bloc.getRadio,
                        builder: (context, snapshot) {
                          return Row(
                            children: <Widget>[
                              Text("Pulang Pergi", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                              Expanded(child: SizedBox()),
                              Radio(
                                groupValue: snapshot.data,
                                onChanged: bloc.setRadio,
                                value: "d",
                              ),
                              Text("Harian", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                              Radio(
                                groupValue: snapshot.data,
                                onChanged: bloc.setRadio,
                                value: "m",
                              ),
                              Text("Bulanan", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                );
              },
            ),
            StreamBuilder<String>(
              initialData: "m",
              stream: bloc.getRadio,
              builder: (context, snapshot) {
                if (snapshot.data == "d") {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text("Jumlah Hari", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                            Expanded(child: SizedBox()),
                            StreamBuilder<int>(
                              stream: bloc.getTotalDay,
                              builder: (context, snapshot) {
                                return DropdownButton<int>(
                                  value: snapshot.data,
                                  onChanged: bloc.setTotalDay,
                                  items: List.generate(30, (i) => DropdownMenuItem(
                                    value: i+1,
                                    child: Text((i+1).toString()),
                                  )),
                                );
                              }
                            ),
                            SizedBox(width: 10),
                            Text("Hari", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  );
                } return SizedBox();
              }
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(allTranslations.text("ADMIN_FEE"), style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                      StreamBuilder<String>(
                        initialData: "m",
                        stream: bloc.getRadio,
                        builder: (context, snapshot) {
                          if (snapshot.data == "m") {
                            if (!widget.data.workerOnlineRegist && !widget.data.workerMore.wmoreStayIn) {
                              return Text(rupiah(1000000), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
                            } else {
                              return Text(rupiah(widget.data.admPrice), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
                            }
                          }else {
                            return Text("${rupiah(widget.data.admPrice)}/Hari", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
                          }
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(allTranslations.text("DETAIL_TRANSACTION"), style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                      SizedBox(height: 15),
                      StreamBuilder<String>(
                        initialData: "m",
                        stream: bloc.getRadio,
                        builder: (context, snapshot) {
                          if (snapshot.data == "d") {
                            return Text("Pekerja ${widget.data.categoryDesc} (${widget.data.workerMore.wmoreStayIn?"Menginap":"Pulang Pergi"}) atas nama ${widget.data.workerName} umur ${widget.data.workerAge} Tahun.\nGaji : ${rupiah(widget.data.categoryPpSalary)}/Hari");
                          }else {
                            if (widget.data.workerOnlineRegist) {
                              return Text("Pekerja ${widget.data.categoryDesc} (${widget.data.workerMore.wmoreStayIn?"Menginap":"Pulang Pergi"}) atas nama ${widget.data.workerName} umur ${widget.data.workerAge} Tahun.\nGaji : ${rupiah(1500000)}/Bulan");
                            }else{
                              return Text("Pekerja ${widget.data.categoryDesc} (${widget.data.workerMore.wmoreStayIn?"Menginap":"Pulang Pergi"}) atas nama ${widget.data.workerName} umur ${widget.data.workerAge} Tahun.\nGaji : ${widget.data.workerSalary}/Bulan");
                            }
                          }
                        }
                      ),
                      SizedBox(height: 10),
                      StreamBuilder<String>(
                        initialData: "m",
                        stream: bloc.getRadio,
                        builder: (context, snapshot) {
                          if (widget.data.workerOnlineRegist || (widget.data.workerMore.wmoreStayIn == false && snapshot.data == "d")) {
                            return Text("Tidak ada garansi penggantian.", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),);
                          }else {
                            if (int.parse(widget.data.admPrice) > 2000000) {
                              return Text("Garansi penggantian selama 4 bulan untuk 2 kali penggantian.", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),);
                            }else {
                              if (widget.data.workerMore.wmoreStayIn) {
                                return Text("Garansi penggantian selama 3 bulan untuk 2 kali penggantian.", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),);
                              }else {
                                return Text("Garansi penggantian selama 2 bulan untuk 1 kali penggantian.", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),);

                              }
                            }
                          }
                        },
                      ),
                      StreamBuilder<String>(
                        initialData: "m",
                        stream: bloc.getRadio,
                        builder: (context, snapshot) {
                          if (snapshot.data == "d") {
                            return Column(
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text("Catatan : Pekerja yang diambil harian, gaji pekerja harus diserahkan kepada House Solutions terlebih dahulu.", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 12))
                              ],
                            );
                          }else {
                            return SizedBox();
                          }
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                      StreamBuilder<String>(
                        initialData: "m",
                        stream: bloc.getRadio,
                        builder: (context, snapshot) {
                          if (snapshot.data == "d") {
                            return StreamBuilder<int>(
                              stream: bloc.getTotalDay,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(rupiah((int.parse(widget.data.admPrice) + int.parse(widget.data.categoryPpSalary)) * snapshot.data), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
                                } return Text(rupiah(int.parse(widget.data.admPrice) + int.parse(widget.data.categoryPpSalary)), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
                              }
                            );
                          } return Text(int.parse(widget.data.admPrice) > 50000 ? rupiah(widget.data.admPrice) : rupiah(1000000), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder<String>(
                    stream: bloc.getPaymnetMethod,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Pilih Metode Pembayaran", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                          SizedBox(height: 15),
                          Card(
                            child: ListTile(
                              onTap: () => bloc.setPaymentMethod("tf"),
                              leading: Image.asset(R.assetsImagesTf, width: 60, height: 60),
                              title: Text("Transfer Bank"),
                              subtitle: Text("Mandiri, BRI, BNI"),
                              trailing: snapshot.hasData && snapshot.data == "tf" ? Icon(Icons.check, color: Theme.of(context).primaryColor):null,
                              selected: snapshot.hasData && snapshot.data == "tf",
                            ),
                          ),
                          Card(
                            child: ListTile(
                              onTap: () => bloc.setPaymentMethod("midtrans"),
                              enabled: false,
                              leading: Image.asset(R.assetsImagesMidtrans, width: 60, height: 60),
                              title: Text("Midtrans"),
                              // subtitle: Text("Gopay, Credit Card"),
                              subtitle: Text("Belum dapat digunakan", style: TextStyle(color: Colors.red)),
                              trailing: snapshot.hasData && snapshot.data == "midtrans" ? Icon(Icons.check, color: Theme.of(context).primaryColor):null,
                              selected: snapshot.hasData && snapshot.data == "midtrans",
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              width: double.infinity,
              child: StreamBuilder<bool>(
                initialData: false,
                stream: bloc.isLoading,
                builder: (context, snapshot) {
                  return RaisedButton(
                    onPressed: snapshot.data ? null : () => bloc.doOrder(context, widget.data.idWorker, widget.idCategory),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(snapshot.data ? "Memproses Trasaksi...":"Proses Transaksi", style: TextStyle(fontSize: 18)),
                    ),
                    colorBrightness: Brightness.dark,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}