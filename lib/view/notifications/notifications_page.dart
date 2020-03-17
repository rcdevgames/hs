import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/notification_bloc.dart';
import 'package:housesolutions/model/notice_model.dart';
import 'package:housesolutions/model/notification.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';

class NotificationsPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<NotificationBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(allTranslations.text("NOTIFICATION")),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
      ),
      body: StreamBuilder<List<Notifications>>(
        stream: bloc.getNotif,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: snapshot.error,
                onPressed: () {
                  bloc.setNotif(null);
                  bloc.loadNotification();
                },
                buttonText: "Try Again",
              ),
            ); 
          } else if (snapshot.hasData) {
            if (snapshot.data.length < 1) return Center(child: Text("Tidak ada notifikasi"));
            return RefreshIndicator(
              key: _refreshKey,
              onRefresh: bloc.loadNotification,
              child: ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int i) => Divider(),
                itemBuilder: (BuildContext context, int i) => ListTile(
                  // onTap: snapshot.data[i].noticeId == "0" ? null : () => navService.navigateTo("/notice-detail", snapshot.data[i]),
                  leading: Icon(i%2 == 0 ? Icons.notifications_active:Icons.notifications),
                  title: Text(snapshot.data[i].notifContent),
                  subtitle: snapshot.data[i].noticeId == "0" ? null : Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                    // height: 200,
                    // color: Colors.amber,
                    child: snapshot.data[i].notifImage == null ? SizedBox() : CachedNetworkImage(
                      imageUrl: snapshot.data[i].notifImage,
                      fit: BoxFit.cover,
                      placeholder: (ctx, i) => LoadingBlock(),
                    ),
                  ),
                  // enabled: (i%2 == 0),
                ),
              ),
            );
          } return LoadingBlock();
        }
      )
    );
  }
}