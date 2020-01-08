import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/product_bloc.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/search_worker.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';
import 'package:housesolutions/view/product/product_detail_page.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:housesolutions/widget/notfound.dart';
import 'package:indonesia/indonesia.dart';
import 'package:lazy_load_refresh_indicator/lazy_load_refresh_indicator.dart';
import 'package:responsive_screen/responsive_screen.dart';

class ProductListPage extends StatefulWidget {
  Categories category;
  String stayIn;
  String regular;
  ProductListPage(this.category, this.stayIn, this.regular);

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
    bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular);
  }

  @override
  void dispose() {
    BlocProvider.disposeBloc<ProductBloc>();
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

    String categoryName(String stayIn, String regular) {
      if (stayIn == "yes" && regular == "yes") {
        return "Regular";
      }else if (stayIn == "no" && regular == "yes") {
        return "PP/Harian";
      }else if(stayIn == "all" && regular == "no") {
        return "Online";
      }
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("${widget.category.categoryDesc} (${categoryName(widget.stayIn, widget.regular)})"),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
      ),
      body: StreamBuilder<SearchWorker>(
        stream: bloc.getWorkers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.data.length == 0) {
              // return NotFound(
              //   key: _refreshKey,
              //   onRefresh: () => bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular),
              //   image_asset: "assets/Images/empty_worker.png"
              // );
              return Center(
                child: Image.asset(R.assetsImagesNotFound, scale: 3.5),
              );
            }

            return LazyLoadRefreshIndicator(
              onRefresh: () => bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular),
              onEndOfPage: () => snapshot.data.page <= snapshot.data.paging ? null : bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular, snapshot.data.page + 1),
              child: GridView.count(
                primary: true,
                crossAxisCount: 2,
                childAspectRatio: 0.80,
                children: snapshot.data.data.map((worker) {
                  return InkWell(
                    onTap: () async {
                      var loggedin = await sessions.checkAuth();
                      if (loggedin) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailPage(worker.idWorker, widget.category)));
                      }else {
                        navService.navigateTo("/login");
                      }
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  color: Theme.of(context).primaryColor,
                                  height: hp(23),
                                  width: double.infinity,
                                  child: avatarName(worker.workerName),
                                ),
                                SizedBox(
                                  height: hp(23),
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
                            SizedBox(height: 5),
                            Text("${worker.workerName}", textAlign: TextAlign.center),
                            Text(worker.districtName, style: TextStyle(fontSize: 10)),
                            Builder(
                              builder: (context) {
                                if (worker.workerSingleApp) {
                                  return Text("Gaji : ${rupiah(1500000)}/Bulan", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold));
                                }else {
                                  if (worker.wmoreStayIn) {
                                    return Text("Gaji : ${rupiah(worker.workerSalary)}/Bulan", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold));
                                  }else{
                                    return Text("Gaji : ${rupiah(worker.categoryPpSalary)}/Hari", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold));
                                  }
                                }
                              }
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("${worker.workerAge} ${allTranslations.text('YEARSOLD')}", textAlign: TextAlign.center),
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
      floatingActionButton: StreamBuilder<SearchWorker>(
        stream: bloc.getWorkers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              icon: Icon(FontAwesomeIcons.filter, color: Colors.white, size: 16),
              label: Text("Filter", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                var data = await navService.navigateTo("/product-filter");
                if (data != null) {
                  bloc.setWorkers(null);
                  bloc.fetchWorker(widget.category.idCategory, widget.stayIn, widget.regular);
                }
              },
            );
          } return SizedBox();
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}