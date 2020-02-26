import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/model/job_inform_model.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/view/product/product_detail_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';
import 'package:responsive_screen/responsive_screen.dart';

class JobDetailPage extends StatefulWidget {
  JobInform data;
  JobDetailPage(this.data);

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 140.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "Detail Request Pekerja",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(R.assetsImagesHeader), fit: BoxFit.fitWidth)
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 5,
                  child: IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: navService.navigatePop
                  )
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                width: wp(100),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Judul"),
                    Text(widget.data.jobTitle, style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 5),
                    Text("Lokasi Penempatan Kerja"),
                    Text(widget.data.jobPlacement, style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 5),
                    Text("Keterangan Pekerjaan"),
                    Text(widget.data.jobDesc, style: TextStyle(fontWeight: FontWeight.w700), softWrap: true),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Text("Pekerja yang berminat", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Flexible(
            child: ListView(
              children: widget.data.workers.map((worker) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    child: ListTile(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailPage(worker.idWorker, widget.data.idCategory))),
                      leading: SizedBox(
                        width: 50,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: worker.workerImage,
                          placeholder: (ctx, i) => LoadingBlock(),
                        ),
                      ),
                      title: Text("${worker.workerName} | ${worker.workerAge} Tahun"),
                      subtitle: Text(rupiah(worker.workerSalary)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.yellow),
                          Text(worker.workerRating, style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}