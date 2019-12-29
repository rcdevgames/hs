import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/product_bloc.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/search_worker.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:housesolutions/widget/notfound.dart';
import 'package:indonesia/indonesia.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:responsive_screen/responsive_screen.dart';

class ProductListPage extends StatefulWidget {
  Categories category;
  String stayIn;
  String regular;

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<ProductBloc>();

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    Widget avatarName(String name) {
      var arr_name = name.split(" ");
      name = arr_name[0][0].toUpperCase();
      if (arr_name.length > 1) {
        name += arr_name[1][0].toUpperCase();
      }
      return Center(
        child: Text(name, style: TextStyle(fontSize: wp(10), color: Colors.white)),
      );
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(""),
      ),
      body: StreamBuilder<SearchWorker>(
        stream: bloc.getWorkers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.data.length == 0) {
              return NotFound(
                key: _refreshKey,
                onRefresh: () => bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular),
                image_asset: ""
              );
            }

            return RefreshIndicator(
              key: _refreshKey,
              onRefresh: () => bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular),
              child: SingleChildScrollView(
                child: LazyLoadScrollView(
                  onEndOfPage: () => bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular, snapshot.data.page + 1),
                  child: GridView.count(
                    primary: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.80,
                    children: snapshot.data.data.map((worker) {
                      return InkWell(
                        // onTap: () => bloc.openDetail(productBloc.workers.data[i].idWorker, widget.category),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Builder(
                                  builder: (context) {
                                    if (worker.stayIn != true) {
                                      return Banner(
                                        location: BannerLocation.topStart,
                                        message: "Pulang Pergi",
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              color: Theme.of(context).primaryColor,
                                              height: hp(20),
                                              width: double.infinity,
                                              child: avatarName(worker.workerName),
                                            ),
                                            SizedBox(
                                              height: hp(20),
                                              width: double.infinity,
                                              child: CachedNetworkImage(
                                                imageUrl: worker.workerProfile,
                                                placeholder: (ctx, id) => avatarName(worker.workerName),
                                                errorWidget: (ctx, id, o) => avatarName(worker.workerName),
                                                fit: BoxFit.cover,
                                                alignment: AlignmentDirectional.topCenter,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }else{
                                      return Stack(
                                        children: <Widget>[
                                          Container(
                                            color: Theme.of(context).primaryColor,
                                            height: hp(20),
                                            width: double.infinity,
                                            child: avatarName(worker.workerName),
                                          ),
                                          SizedBox(
                                            height: hp(20),
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              imageUrl: worker.workerProfile,
                                              placeholder: (ctx, id) => avatarName(worker.workerName),
                                              errorWidget: (ctx, id, o) => avatarName(worker.workerName),
                                              fit: BoxFit.cover,
                                              alignment: AlignmentDirectional.topCenter,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                ),
                                SizedBox(height: 5),
                                Text("${worker.workerName} (${worker.workerAge})", textAlign: TextAlign.center),
                                Text(worker.districtName, style: TextStyle(fontSize: 10)),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(rupiah(worker.workerSalary), style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                                    RatingBarIndicator(
                                      rating: double.parse(worker.workerRating),
                                      itemSize: 13,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          } else if(snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: snapshot.error,
                buttonText: "ulangi",
                onPressed: () {
                  bloc.setWorkers(null);
                  bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular);
                },
              ),
            );
          } return LoadingBlock();
        }
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          label: Icon(FontAwesomeIcons.filter),
          icon: Text("Filter"),
          onPressed: () async {
            var data = await navService.navigateTo("/product-filter");
            if (data != null) {
              bloc.setWorkers(null);
              bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular);
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}