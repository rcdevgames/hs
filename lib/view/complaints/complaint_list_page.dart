import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/complaint_bloc.dart';
import 'package:housesolutions/model/complaint_model.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';

class ComplaintListPage extends StatefulWidget {
  @override
  _ComplaintListPageState createState() => _ComplaintListPageState();
}

class _ComplaintListPageState extends State<ComplaintListPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<ComplaintBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.fetchComplaints();
  }

  @override
  void dispose() { 
    BlocProvider.disposeBloc<ComplaintBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Daftar Pengaduan"),
      ),
      body: StreamBuilder<List<Complaints>>(
        stream: bloc.getComplaints,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Image.asset(R.assetsImagesDataTidakTersedia);
            }

            return RefreshIndicator(
              key: _refreshKey,
              onRefresh: bloc.fetchComplaints,
              child: ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (ctx, i) => Divider(),
                itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  onTap: () => navService.navigateTo("/complaint-detail", [snapshot.data[i].idComplaint, snapshot.data[i].complaintTitle]),
                  leading: Builder(builder: (ctx) {
                    switch (snapshot.data[i].complaintStatus) {
                      case "process": return Icon(Icons.autorenew, color: Colors.blue);
                      case "solved": return Icon(Icons.check, color: Colors.green);
                      default: return Icon(Icons.access_time, color: Colors.amber);
                    }
                  }),
                  title: Text("#${snapshot.data[i].complaintId.toUpperCase()}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text(tanggal(snapshot.data[i].complaintCreated), style: TextStyle(fontSize: 10)),
                      Text(snapshot.data[i].complaintTitle),
                    ],
                  ),
                );
               },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorPage(message: snapshot.error, onPressed: () {
                bloc.setComplaints(null);
                bloc.fetchComplaints();
              }, buttonText: "Ulangi"),
            );
          } return LoadingBlock();
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navService.navigateTo("/complaint-form"), 
        label: Text("Buat Pengaduan", style: TextStyle(color: Colors.white))
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}