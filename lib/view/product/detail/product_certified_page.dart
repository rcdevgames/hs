import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/model/worker.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/widget/loading.dart';

class ProductCertifiedPage extends StatelessWidget {
  List<WorkerCertificate> data;
  ProductCertifiedPage(this.data);

  final _key = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Sertifikat Pekerja"),
      ),
      body: data.length > 0 ? SingleChildScrollView(
        child: Column(
          children: data.map((certified) => Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(certified.certificateTitle),
                    CachedNetworkImage(
                      imageUrl: certified.certificateImage,
                      placeholder: (ctx, s) => LoadingBlock(),
                    )
                  ],
                ),
              ),
            ),
          )).toList(),  
        ),
      ) : Center(
        child: Image.asset(R.assetsImagesDataTidakTersedia),
      ),
    );
  }
}