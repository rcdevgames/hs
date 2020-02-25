import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/bloc/user_bloc.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';
import 'package:package_info/package_info.dart';
import 'package:responsive_screen/responsive_screen.dart';

class UserPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _key = GlobalKey<ScaffoldState>();

  String initialName(String data) {
    var split_name = data.split(" ");
    if (split_name != null && split_name.length > 0) {
      return "${split_name[0][0].toUpperCase()}${split_name.length > 1 ? split_name[1][0].toUpperCase():''}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    final bloc = BlocProvider.getBloc<UserBloc>();

    return SafeArea(
      child: StreamBuilder<User>(
        stream: bloc.getUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return RefreshIndicator(
            //   key: _refreshIndicatorKey,
            //   onRefresh: bloc.loadUser,
            //   child: ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (ctx, i) => SizedBox(height: 10),
            //   ),
            // );
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
                          Positioned(
                            top: 20,
                            width: wp(100),
                            child: Text("Hai ${snapshot.data.customerName} !", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center)
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Flexible(
                        child: Stack(
                          children: <Widget>[
                            Arc(
                              edge: Edge.TOP,
                              height: 30,
                              child: Container(color: Colors.white),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Text(snapshot.data.districtName, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Column(
                                    children: <Widget>[
                                      Text("GAJI PEKERJA YA!", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600)),
                                      Text(rupiah(0), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        height: 20,
                                        child: RaisedButton(
                                          color: Colors.blue,
                                          colorBrightness: Brightness.dark,
                                          onPressed: bloc.detailSalary,
                                          child: Text("Detail"),
                                        ),
                                      )
                                    ],
                                  )
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                                  child: FlatButton(
                                    onPressed: () => navService.navigateTo("/complaint"),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Icon(Icons.help_outline),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text("Pengaduan")
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox()
                                        ),
                                        
                                      ],
                                    ),
                                  )
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: FlatButton(
                                    onPressed: () => navService.navigateTo("/user-edit"),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Icon(Icons.featured_play_list),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text("Ubah Profil")
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox()
                                        ),
                                        
                                      ],
                                    ),
                                  )
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: FlatButton(
                                    onPressed: () => navService.navigateTo("/agreement-page"),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Icon(Icons.security),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text("Syarat Ketentuan Layanan")
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox()
                                        ),
                                        
                                      ],
                                    ),
                                  )
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: FlatButton(
                                    onPressed: () async {
                                      PackageInfo packageInfo = await PackageInfo.fromPlatform();
                                      showAlert(
                                        context: context,
                                        title: "Tentang Aplikasi",
                                        body: "House Solutions © 2020\nPT Malau Solutions Indonesia\n\nv${packageInfo.version}+${packageInfo.buildNumber}"
                                      );
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Icon(Icons.info_outline),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text("Tentang Aplikasi")
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox()
                                        ),
                                        
                                      ],
                                    ),
                                  )
                                ),
                                Divider(
                                  indent: 30,
                                  endIndent: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                                FlatButton(onPressed: () => showAlert(
                                  context: context,
                                  title: "Keluar Akun",
                                  body: "Apakah anda yakin?",
                                  actions: [
                                    AlertAction(
                                      text: "Batal",
                                      onPressed: () => null
                                    ),
                                    AlertAction(
                                      text: "Yakin",
                                      onPressed: bloc.logout
                                    )
                                  ]
                                ), child: Text("Keluar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red)))
                              ],
                            )
                          ],
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
                          child: Container(
                              color: Theme.of(context).primaryColor,
                              child: snapshot.data.customerImage == null ? Builder(
                                builder: (context) {
                                  var split_name = snapshot.data.customerName?.split(" ");
                                  var name = "";
                                  if (split_name != null && split_name.length > 0) {
                                    name = "${split_name[0][0].toUpperCase()}${split_name.length > 1 ? split_name[1][0].toUpperCase():''}";
                                  }
                                  return Center(child: Text(name, style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center));
                                },
                              ) : CachedNetworkImage(
                                imageUrl: snapshot.data.customerImage,
                                fit: BoxFit.cover,
                                placeholder: (ctx, i) => Center(
                                  child: LoadingBlock(Colors.white),
                                ),
                                errorWidget: (ctx, i, obj) => Center(
                                  child: Text("Error Show Profile Picture\nScrolldown to refresh", style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                                ),
                              ),
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: snapshot.error,
                buttonText: "Ulangi Lagi",
                onPressed: () {
                  bloc.setUser(null);
                  bloc.fetchUser();
                },
              ),
            );
          } return LoadingBlock();
        }
      ),
    );
  }
}