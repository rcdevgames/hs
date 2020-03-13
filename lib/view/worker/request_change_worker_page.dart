import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/util/validator.dart';
import 'package:housesolutions/widget/loading.dart';

class RequestChangeWorkerPage extends StatefulWidget {
  @override
  _RequestChangeWorkerPage createState() => _RequestChangeWorkerPage();
}

class _RequestChangeWorkerPage extends State<RequestChangeWorkerPage> with ValidationMixin {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<OrderBloc>();

    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
            title: Text("Form Penggantian Tenaga Kerja"),
          ),
          body: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Tuliskan alasan anda", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 10),
                  Container(
                    child: TextFormField(
                      validator: validateRequired,
                      decoration: InputDecoration(
                        hintText: "Saya ingin menukarkan tenaga kerja karena...",
                        border: InputBorder.none  
                      ),
                      maxLines: 8,
                      onSaved: bloc.setReason,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Kirim", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18)),
                      onPressed: () => bloc.requestChangeWorker(_form),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text("Note : \n- Proses penggantian akan memakan waktu 1-10 hari kerja.\n- Pengajuan penggantian tenaga kerja hanya dapat dilakukan maksimal 3 hari sebelum masa garansi habis.\n- Anda diwajibkan membayar gaji tenaga kerja sebelumnya dengan perhitungan prorata.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.red)),
                ],
              ),
            ),
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