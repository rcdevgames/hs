import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class PreviewImageApprovalPage extends StatelessWidget {
  int idTrans;
  String url;
  PreviewImageApprovalPage(this.idTrans, this.url);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<OrderBloc>();
    
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Bukti Pembayaran"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () => showAlert(
            context: context,
            title: "Konfirmasi Ulang Pembayaran",
            body: "Ulang Unggah bukti pembayaran dari ?",
            barrierDismissible: true,
            actions: [
              AlertAction(text: "Batal", onPressed: null),
              AlertAction(
                text: "Camera",
                onPressed: () => bloc.uploadImage(context, idTrans, ImageSource.camera)
              ),
              AlertAction(
                text: "Galery",
                onPressed: () => bloc.uploadImage(context, idTrans, ImageSource.gallery)
              )
            ]
          ))
        ],
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(url),
      )
    );
  }
}