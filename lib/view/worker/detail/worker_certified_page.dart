import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/widget/loading.dart';

class WorkerCertifiedPage extends StatelessWidget {
  List<WorkerCertificate> certified;
  List<WorkerPhoto> photos;
  WorkerCertifiedPage(this.certified, this.photos);

  final _key = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Sertifikat Pekerja"),
      ),
      body: certified.length > 0 && photos.length > 0 ? SingleChildScrollView(
        child: Column(
          children: List.generate(photos.length, (i) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(photos[i].title),
                      CachedNetworkImage(
                        imageUrl: photos[i].image,
                        placeholder: (ctx, s) => LoadingBlock(),
                      )
                    ],
                  ),
                ),
              ),
            );
          })..addAll(List.generate(certified.length, (i) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(certified[i].certificateTitle),
                      CachedNetworkImage(
                        imageUrl: certified[i].certificateImage,
                        placeholder: (ctx, s) => LoadingBlock(),
                      )
                    ],
                  ),
                ),
              ),
            );
          })),  
        ),
      ) : Center(
        child: Image.asset(R.assetsImagesDataTidakTersedia),
      ),
    );
  }
}