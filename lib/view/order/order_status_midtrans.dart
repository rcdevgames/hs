import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/view/home/layout.dart';
import 'package:responsive_screen/responsive_screen.dart';

class OrderStatusMidtransPage extends StatefulWidget {
  String status;
  OrderStatusMidtransPage(this.status);

  @override
  _OrderStatusMidtransPageState createState() => _OrderStatusMidtransPageState();
}

class _OrderStatusMidtransPageState extends State<OrderStatusMidtransPage> {
  final _key = GlobalKey<ScaffoldState>();
  Timer _timer;
  int _count;

  @override
  void initState() { 
    super.initState();
    _count = 6;
    doCount();
  }

  @override
  void dispose() { 
    _timer?.cancel();
    super.dispose();
  }

  doCount() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_count < 1) {
            timer.cancel();
            var bloc = BlocProvider.getBloc<LayoutBloc>();
            bloc.setIndex(2);
            navService.navigatePopUntil("/main");
          } else {
            _count = _count - 1;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Status Transaksi"),
      ),
      body: Builder(
        builder: (_) {
          switch (widget.status) {
            case "canceled": return Container(
              padding: const EdgeInsets.fromLTRB(8, 35, 8, 20),
              child: Column(
                children: <Widget>[
                  Text("Pembayaran Belum selesai", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  Text("Pesanan ini akan hangus dalam 30 menit.\nLakukan pembayaran agar dapat terhubung dengan pekerja.", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center),
                  Expanded(
                    child: Center(
                      child: Icon(FontAwesomeIcons.times, color: Colors.red, size: wp(40)),
                    )
                  ),
                  Text("Redirect dalam ${_count} detik", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                ],
              ),
            );
            case "pending": return Container(
              padding: const EdgeInsets.fromLTRB(8, 35, 8, 20),
              child: Column(
                children: <Widget>[
                  Text("Menunggu pembayaran", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  Text("Pesanan ini akan hangus dalam 30 menit.\nLakukan Segera pembayaran agar dapat terhubung dengan pekerja.", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center),
                  Expanded(
                    child: Center(
                      child: Icon(FontAwesomeIcons.hourglassHalf, color: Colors.amber, size: wp(40)),
                    )
                  ),
                  Text("Redirect dalam ${_count} detik", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                ],
              ),
            );
            case "success": return Container(
              padding: const EdgeInsets.fromLTRB(8, 35, 8, 20),
              child: Column(
                children: <Widget>[
                  Text("Transaksi Berhasil", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  Text("\nLakukan pembayaran agar dapat terhubung dengan pekerja.", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center),
                  Expanded(
                    child: Center(
                      child: Icon(FontAwesomeIcons.checkCircle, color: Colors.green, size: wp(40)),
                    )
                  ),
                  Text("Redirect dalam ${_count} detik", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                ],
              ),
            );
            default: return SizedBox();
          }
        }
      ),
    );
  }
}