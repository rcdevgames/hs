import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/model/bank.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indonesia/indonesia.dart';

class PaymentManualPage extends StatefulWidget {
  int idTrans;
  int totalPayment;
  PaymentManualPage(this.idTrans, this.totalPayment);

  @override
  _PaymentManualPageState createState() => _PaymentManualPageState();
}

class _PaymentManualPageState extends State<PaymentManualPage> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<OrderBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.fetchBank();
  }

  @override
  void dispose() {
    bloc.setBank(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text("Pembayaran Transfer Bank"),
            brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
          ),
          body: StreamBuilder<List<Bank>>(
            stream: bloc.getBanks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total Pembayaran", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                              Text(rupiah(widget.totalPayment), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Daftar Bank", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black45, fontSize: 20)),
                              SizedBox(height: 10),
                            ]..addAll(snapshot.data.map((bank) {
                              return ListTile(
                                leading: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CachedNetworkImage(
                                    imageUrl: bank.bankIcon,
                                    placeholder: (ctx, i) => LoadingBlock(),
                                  ),
                                ),
                                title: Text(bank.bankAccountNumber),
                                subtitle: Text(bank.bankAccountName),
                              );
                            }).toList())..addAll([
                              SizedBox(height: 10),
                              Text("Transfer ke salah 1 bank diatas dan unggah bukti pembayaran anda dengan menekan tombol dibawah ini", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red)),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 10, 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            showAlert(
                              context: context,
                              title: "Konfirmasi Pembayaran",
                              body: "Unggah bukti pembayaran dari ?",
                              barrierDismissible: true,
                              actions: [
                                AlertAction(
                                  text: "Camera",
                                  onPressed: () => bloc.uploadImage(context, widget.idTrans, ImageSource.camera)
                                ),
                                AlertAction(
                                  text: "Galery",
                                  onPressed: () => bloc.uploadImage(context, widget.idTrans, ImageSource.gallery)
                                )
                              ]
                            );
                          },
                          child: Text("Konfirmasi Pembayaran", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                );
              }else if(snapshot.hasError) {
                return Center(
                  child: ErrorPage(
                    message: snapshot.error,
                    buttonText: allTranslations.text("TRY_AGAIN"),
                    onPressed: () {
                      bloc.setBank(null);
                      bloc.fetchBank();
                    },
                  ),
                );
              } return LoadingBlock();
            }
          ),
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: bloc.isLoading,
          builder: (context, snapshot) {
            return Loading(snapshot.data);
          }
        )
      ],
    );
  }
}