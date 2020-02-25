import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/home_bloc.dart';
import 'package:housesolutions/model/promote.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:responsive_screen/responsive_screen.dart';

class PromoteListPage extends StatefulWidget {
  @override
  _PromoteListPageState createState() => _PromoteListPageState();
}

class _PromoteListPageState extends State<PromoteListPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<HomeBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.fetchPromote();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("News"),
        brightness: Brightness.dark,
      ),
      body: StreamBuilder<List<Promote>>(
        stream: bloc.getPromotes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data.map((promote) => InkWell(
                  onTap: () => navService.navigateTo("/promote-detail", promote),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: double.infinity,
                    height: hp(27),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(promote.promoteBanner),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: hp(10),
                          color: Colors.black.withOpacity(0.4),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(promote.promoteTitle, style: TextStyle(fontSize: wp(3.5), fontWeight: FontWeight.w800, color: Colors.white)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )).toList(),
              ),
            );
          } return SizedBox(
            height: 200,
            child: Center(
              child: LoadingBlock(),
            ),
          );
        }
      ),
    );
  }
}