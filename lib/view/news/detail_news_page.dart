import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:housesolutions/bloc/news_bloc.dart';
import 'package:housesolutions/model/news_detail_model.dart';
import 'package:housesolutions/model/news_model.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:indonesia/indonesia.dart';

class NewsDetailPage extends StatefulWidget {
  News data;
  NewsDetailPage(this.data);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<NewsBloc>();
  final ctrl = TextEditingController();

  @override
  void initState() { 
    super.initState();
    bloc.fetchDetailNews(widget.data.newsSlug);
  }

  @override
  void dispose() { 
    super.dispose();
    bloc.setDetailNews(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              brightness: Brightness.dark,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.data.newsTitle,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  softWrap: true,
                ),
                background: CachedNetworkImage(
                  imageUrl: widget.data.newsBanner,
                  placeholder: (ctx, s) => LoadingBlock(),
                  errorWidget: (ctx, s, o) => Center(
                    child: Text("Failed to load image", textAlign: TextAlign.center),
                  ),
                  fit: BoxFit.cover,
                )
              ),
            ),
          ];
        },
        body: StreamBuilder<NewsDetail>(
          stream: bloc.getDetailNews,
          builder: (context, news) {
            if (news.hasData) {
              return RefreshIndicator(
                key: _refreshKey,
                onRefresh: () => bloc.fetchDetailNews(widget.data.newsSlug),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.person, color: Colors.grey),
                              SizedBox(width: 3),
                              Text(news.data.userFullname, style: TextStyle(color: Colors.grey, fontSize: 16)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today, color: Colors.grey),
                              SizedBox(width: 3),
                              Text(tanggal(news.data.newsCreated), style: TextStyle(color: Colors.grey, fontSize: 16)),
                            ],
                          ),
                          Html(data: news.data.newsContent??""),
                          Divider(),
                          Text("${news.data.comments.length} Komentar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Column(
                            children: news.data.comments.map((comment) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: CachedNetworkImage(
                                      imageUrl: "https://news.housesolutionsindonesia.com/assets/images/user-icon.png",
                                    ),
                                    title: Text(comment.ncommentName),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(tanggal(comment.ncommentCreated)),
                                        SizedBox(height: 5),
                                        Html(data: comment.ncommentContent??""),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: comment.subComment.map((subComment) {
                                            return ListTile(
                                              leading: CachedNetworkImage(
                                                imageUrl: "https://news.housesolutionsindonesia.com/assets/images/user-icon.png",
                                              ),
                                              title: Text(subComment.scommentName),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(tanggal(subComment.scommentCreated)),
                                                  SizedBox(height: 5),
                                                  Html(data: subComment.scommentContent??""),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        Divider(height: 10),
                                        Text("Masukan Balasan Komentar", style: TextStyle(fontWeight: FontWeight.w700)),
                                        StreamBuilder<bool>(
                                          initialData: false,
                                          stream: bloc.isLoading,
                                          builder: (context, snapshot) {
                                            return TextField(
                                              controller: bloc.ctrl_sub[news.data.comments.indexOf(comment)],
                                              enabled: !snapshot.data,
                                              maxLines: 3,
                                              textInputAction: TextInputAction.newline,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                                                hintText: "Tulis Balasan Komentar Disini",
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 1),
                                                  borderRadius: BorderRadius.circular(5)
                                                )
                                              ),
                                            );
                                          }
                                        ),
                                        StreamBuilder<bool>(
                                          initialData: false,
                                          stream: bloc.isLoading,
                                          builder: (context, snapshot) {
                                            return RaisedButton(
                                              onPressed: snapshot.data ? null : () => bloc.doSubComment(context, widget.data.newsSlug, int.parse(widget.data.idNews), int.parse(comment.idNcomment), bloc.ctrl_sub[news.data.comments.indexOf(comment)].text, bloc.ctrl_sub[news.data.comments.indexOf(comment)]),
                                              color: Theme.of(context).primaryColor,
                                              disabledColor: Colors.grey,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(snapshot.data ? "Menyimpan Komentar" : "Simpan Komentar", style: TextStyle(fontWeight: FontWeight.bold, color: snapshot.data ? Colors.black : Colors.white)),
                                                ),
                                              ),
                                            );
                                          }
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Divider(),
                          Text("Masukan Komentar Anda", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          StreamBuilder<bool>(
                            initialData: false,
                            stream: bloc.isLoading,
                            builder: (context, snapshot) {
                              return TextField(
                                controller: ctrl,
                                enabled: !snapshot.data,
                                maxLines: 8,
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                                  hintText: "Tulis Komentar Anda Disini",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(5)
                                  )
                                ),
                              );
                            }
                          ),
                          StreamBuilder<bool>(
                            initialData: false,
                            stream: bloc.isLoading,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.data ? null : () => bloc.doComment(context, widget.data.newsSlug, int.parse(widget.data.idNews), ctrl.text, ctrl),
                                color: Theme.of(context).primaryColor,
                                disabledColor: Colors.grey,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(snapshot.data ? "Menyimpan Komentar" : "Simpan Komentar", style: TextStyle(fontWeight: FontWeight.bold, color: snapshot.data ? Colors.black : Colors.white)),
                                  ),
                                ),
                              );
                            }
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );   
            }else if(news.hasError) {
              return Center(
                child: ErrorPage(
                  message: news.error,
                  buttonText: "ulangi",
                  onPressed: () {
                    bloc.setDetailNews(null);
                    bloc.fetchDetailNews(widget.data.newsSlug);
                  },
                ),
              );
            } return LoadingBlock();
          }
        ),
      ),
    );
  }
}