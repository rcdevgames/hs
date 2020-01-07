import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/model/worker.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:indonesia/indonesia.dart';

class ConfirmationOrder extends StatelessWidget {
  int idCategory;
  Worker data;
  ConfirmationOrder(this.idCategory, this.data);

  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<OrderBloc>();

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
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(allTranslations.text("ADMIN_FEE"), style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 20)),
                      Text(rupiah(data.admPrice), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                      Text("Pekerja ${data.categoryDesc} atas nama ${data.workerName} umur ${data.workerAge} Tahun.\nGaji : ${data.workerSalary}/Bulan")
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