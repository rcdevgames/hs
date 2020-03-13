import 'package:flutter/material.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:indonesia/indonesia.dart';

class WorkerMorePage extends StatelessWidget {
  MyWorker data;
  WorkerMorePage(this.data);

  final _key = GlobalKey<ScaffoldState>();

  Widget profileData(context, {String key, String value, bool valueBold = false}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(key, style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(":")
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(flex:2, child: Text(value??"-", style: TextStyle(fontWeight: valueBold ? FontWeight.w700:FontWeight.normal), softWrap: true,)),
            ],
          ),
        ),
        Divider(color: Theme.of(context).primaryColor)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Detail Pekerja ${data.workerName}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileData(context, key: "Nama Lengkap", value: data.workerName),
            profileData(context, key: "Usia", value: "${data.workerAge} Tahun"),
            profileData(context, key: "Pekerjaan", value: data.categoryDesc),
            profileData(context, key: "Menginap", value: data.workerMore.wmoreStayIn ? "Bisa Menginap":"Pulang Pergi"),
            profileData(context, key: "Status", value: data.workerMore.wmoreStatus),
            profileData(context, key: "Anak", value: "${data.workerMore.wmoreChildren??0} Anak"),
            profileData(context, key: "Tinggi Badan", value: data.workerHeight),
            profileData(context, key: "Berat Badan", value: data.workerWeight),
            Builder(
              builder: (context) {
                if (data.onlineRegist??false) {
                  return profileData(context, key: "Gaji", value: "${rupiah(1500000)}/Bulan", valueBold: true);
                }else {
                  if (data.workerMore.wmoreStayIn) {
                    return profileData(context, key: "Gaji", value: "${data.workerSalary}/Bulan", valueBold: true);
                  }else{
                    return profileData(context, key: "Gaji", value: "${rupiah(data.workerSalaryDaily??0)}/Hari | ${rupiah(data.workerSalary)}/Bulan", valueBold: true);
                  }
                }
              }
            ),
            profileData(context, key: "Kota/Kabupaten", value: data.districtName),
            profileData(context, key: "Provinsi", value: data.provinceName),
            profileData(context, key: "Kerja Luar Negeri", value: data.workerMore.wmoreAbroadEx != null && data.workerMore.wmoreAbroadEx ? "Berpengalaman":"Tidak Berpengalaman"),
            profileData(context, key: "Bahasa", value: data.workerMore.wmoreLanguage),
            profileData(context, key: "Phobia", value: data.workerMore.wmorePhobia),
          ],
        ),
      ),
    );
  }
}