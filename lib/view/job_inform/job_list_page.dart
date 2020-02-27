import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/job_bloc.dart';
import 'package:housesolutions/model/job_inform_model.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';
import 'package:responsive_screen/responsive_screen.dart';

class JobListPage extends StatefulWidget {
  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<JobBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.fetchJobList();
  }

  @override
  void dispose() { 
    BlocProvider.disposeBloc<JobBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      body: Column(
        children: <Widget>[
          Container(
            height: 140.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "Daftar Request Pekerja",
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
          Flexible(
            child: StreamBuilder<List<JobInform>>(
              stream: bloc.getJobList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Image.asset(R.assetsImagesDataTidakTersedia),
                    );
                  }
                  return RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: bloc.fetchJobList,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              onTap: () => navService.navigateTo("/job-detail", snapshot.data[i]),
                              title: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on, size: 18, color: Theme.of(context).primaryColor),
                                  Expanded(child: Text(snapshot.data[i].jobPlacement, style: TextStyle(color: Theme.of(context).primaryColor))),
                                  Text(tanggal(snapshot.data[i].jobCreated, shortMonth: true), style: TextStyle(color: Colors.grey))
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text(snapshot.data[i].jobTitle, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25), softWrap: true),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Pekerja yang berminat : ${snapshot.data[i].workers.length} Orang", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      Text(snapshot.data[i].jobPublish ? "Dipublikasikan":"Tidak Dipublikasi", style: TextStyle(color: snapshot.data[i].jobPublish ? Colors.green : Colors.red))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ) 
                    ), 
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: ErrorPage(
                      message: snapshot.error, 
                      buttonText: "Ulangi",
                      onPressed: () {
                        bloc.setJobList(null);
                        bloc.fetchJobList();
                      }
                    ),
                  );
                } return LoadingBlock();

              }
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navService.navigateTo("/job-form"), 
        label: Text("Request Pekerja", style: TextStyle(color: Colors.white))
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}