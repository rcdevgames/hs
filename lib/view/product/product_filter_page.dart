import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/product_bloc.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:responsive_screen/responsive_screen.dart';

class ProductFilterPage extends StatefulWidget {
  @override
  _ProductFilterPageState createState() => _ProductFilterPageState();
}

class _ProductFilterPageState extends State<ProductFilterPage> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<ProductBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.initFilter();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Filter Data"),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(allTranslations.text("PROVINCE"), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(4.0)
            ),
            child: StreamBuilder<List<Province>>(
              stream: bloc.getProvinces,
              builder: (context, prov) {
                return StreamBuilder<int>(
                  stream: bloc.getProvince,
                  builder: (context, snapshot) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: snapshot.data,
                        onChanged: (i) {
                          bloc.setProvince(i);
                          bloc.fetchDistrict(i);
                        },
                        hint: Text(allTranslations.text("ALL_PROVINCE")),
                        items: prov.hasData ? prov.data.map((province) => DropdownMenuItem(
                          child: Text(province.provinceName),
                          value: province.idProvince,
                        )).toList() : [],
                      ),
                    );
                  }
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(allTranslations.text("DISTRICT"), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(4.0)
            ),
            child: StreamBuilder<List<District>>(
              stream: bloc.getDistricts,
              builder: (context, district) {
                return StreamBuilder<int>(
                  stream: bloc.getDistrict,
                  builder: (context, snapshot) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: snapshot.data,
                        onChanged: bloc.setDistrict,
                        hint: Text(allTranslations.text("ALL_DISTRICT")),
                        items: district.hasData ? district.data.map((province) => DropdownMenuItem(
                          child: Text(province.districtName),
                          value: province.idDistrict,
                        )).toList() : [],
                      ),
                    );
                  }
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(allTranslations.text("RATINGS"), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: wp(40),
                  child: TextField(
                    controller: bloc.rat0,
                    onChanged: (val) {
                      if (int.tryParse(val) > 5) {
                        bloc.rat0.text = "5";
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "1-5",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor)
                      )
                    ),
                  ),
                ),
                Text("-", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25), textAlign: TextAlign.center,),
                SizedBox(
                  width: wp(40),
                  child: TextField(
                    controller: bloc.rat1,
                    onChanged: (val) {
                      if (int.tryParse(val) > 5) {
                        bloc.rat1.text = "5";
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "1-5",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor)
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Text(allTranslations.text("SALARY"), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: wp(40),
                  child: TextField(
                    controller: bloc.sal0,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "${allTranslations.text('SALARY')} Awal",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor)
                      )
                    ),
                  ),
                ),
                Text("-", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25), textAlign: TextAlign.center,),
                SizedBox(
                  width: wp(40),
                  child: TextField(
                    controller: bloc.sal1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "${allTranslations.text('SALARY')} Akhir",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor)
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 0),
            child: RaisedButton(
              onPressed: () {
                bloc.setRating([double.tryParse(bloc.rat0.text), double.tryParse(bloc.rat1.text)]);
                bloc.setSalary([double.tryParse(bloc.sal0.text), double.tryParse(bloc.sal1.text)]);
                Navigator.pop(context, true);
              },
              child: Text("Tampilan Data", style: TextStyle(color: Colors.white)),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}