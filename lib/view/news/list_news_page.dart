import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/news_bloc.dart';
import 'package:housesolutions/model/news_model.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';

class ListNewsPage extends StatefulWidget {
  int id;
  ListNewsPage(this.id);

  @override
  _ListNewsPageState createState() => _ListNewsPageState();
}

class _ListNewsPageState extends State<ListNewsPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<NewsBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.fetchNews(widget.id);
  }

  @override
  void dispose() {
    bloc.setNews(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Builder(
          builder: (context) {
            if (widget.id == 1) {
              return Text("Solusi Dapur");  
            } else if (widget.id == 2) {
              return Text("Solusi Kesehatan");  
            } if (widget.id == 3) {
              return Text("Solusi Keluarga");  
            }
          }
        ),
      ),
      body: StreamBuilder<List<News>>(
        stream: bloc.getNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.length < 1) {
              return Center(
                child: Image.asset(R.assetsImagesDataTidakTersedia, scale: 2.5),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) => InkWell(
                onTap: () => navService.navigateTo("/news-detail", snapshot.data[i]),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(6, (i == 0) ? 5 : 0, 6, 5),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data[i].newsBanner,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.data[i].newsTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today, size: 13, color: Colors.grey,),
                                  SizedBox(width: 3),
                                  Text(tanggal(snapshot.data[i].newsCreated), style: TextStyle(fontSize: 14, color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }else if(snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: snapshot.error,
                buttonText: "ulangi",
                onPressed: () {
                  bloc.setNews(null);
                  bloc.fetchNews(widget.id);
                },
              ),
            );
          }return LoadingBlock();
        }
      ),
    );
  }
}