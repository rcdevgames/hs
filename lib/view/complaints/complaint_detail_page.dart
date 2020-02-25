import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/complaint_bloc.dart';
import 'package:housesolutions/model/complaint_model.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';
import 'package:responsive_screen/responsive_screen.dart';

class ComplaintDetailPage extends StatefulWidget {
  int id;
  String title;
  ComplaintDetailPage(this.id, this.title);

  @override
  _ComplaintDetailPageState createState() => _ComplaintDetailPageState();
}

class _ComplaintDetailPageState extends State<ComplaintDetailPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<ComplaintBloc>();
  final statusColor = {
    "pending": Colors.amber,
    "process": Colors.blue,
    "solved": Colors.green
  };

  @override
  void initState() { 
    super.initState();
    bloc.getDetailComplaint(widget.id);
  }

  @override
  void dispose() {
    bloc.setComplaint(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.title),
      ),
      body: StreamBuilder<Complaints>(
        stream: bloc.getComplaint,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data.complaintStatus.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: statusColor[snapshot.data.complaintStatus]))
                          ],
                        ),
                        Divider(),
                        Text("Penjelasan", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 3),
                        Text(snapshot.data.complaintContent??"", softWrap: true)
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: () => bloc.getDetailComplaint(widget.id),
                    child: ListView.separated(
                      itemCount: snapshot.data.replies.length,
                      separatorBuilder: (BuildContext context, int index) => Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: snapshot.data.replies[index].complaintType == "admin" ? <Widget>[
                              Text("Admin House Solutions", style: TextStyle(color: Colors.amber)),
                              Text("${tanggal(snapshot.data.replies[index].complaintCreated)} ${snapshot.data.replies[index].complaintCreated.hour}:${snapshot.data.replies[index].complaintCreated.minute}", style: TextStyle(fontSize: 10, color: Colors.grey))
                            ] : <Widget>[
                              Text("${tanggal(snapshot.data.replies[index].complaintCreated)} ${snapshot.data.replies[index].complaintCreated.hour}:${snapshot.data.replies[index].complaintCreated.minute}", style: TextStyle(fontSize: 10, color: Colors.grey)),
                              Text("Saya", style: TextStyle(color: Colors.black45))
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: snapshot.data.replies[index].complaintType == "admin" ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: <Widget>[
                              Divider(),
                              Text(snapshot.data.replies[index].complaintContent??"", textAlign: snapshot.data.replies[index].complaintType == "admin" ? TextAlign.start:TextAlign.end),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ),
                Container(
                  height: hp(12),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: snapshot.data.complaintStatus == "solved" ? null : () => navService.navigateTo("/complaint-form"),
                    child: Text(snapshot.data.complaintStatus == "solved" ? "Sudah clear":"Balas", style: TextStyle(fontSize: 25)),
                    colorBrightness: Brightness.dark,
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorPage(message: snapshot.error, onPressed: () {
                bloc.setComplaint(null);
                bloc.getDetailComplaint(widget.id);
              }, buttonText: "Ulangi"),
            );
          } return LoadingBlock();
        }
      ),
    );
  }
}