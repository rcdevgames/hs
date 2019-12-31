import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/home_bloc.dart';
import 'package:housesolutions/model/banner.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/promote.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';
import 'package:housesolutions/view/product/product_list_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:responsive_screen/responsive_screen.dart';

class HomePage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  Widget menuButton({@required String imageUrl, @required String title, void Function() onPressed, bool isPremium = false}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 50, height: 50,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  // fit: BoxFit.cover,
                  placeholder: (BuildContext context, String data) => SizedBox(child: LoadingBlock(Theme.of(context).primaryColor), width: 50, height: 50),
                  width: 50, height: 50
                ),
              ),
              SizedBox(height: 5),
              Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700), textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
      onTap: onPressed,
    );
  }

  Widget bannerSlide(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fitWidth,
      placeholder: (BuildContext context, String data) => LoadingBlock(Theme.of(context).primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    final bloc = BlocProvider.getBloc<HomeBloc>();
    
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: StreamBuilder<User>(
          stream: bloc.getUser,
          builder: (context, snapshot) {
            return Text(snapshot.hasData ? "Hai, ${snapshot.data.customerName}":allTranslations.text("WELCOME"), style: TextStyle(color: Theme.of(context).primaryColor));
          }
        ),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: Positioned(
          bottom: 0,
          child: StreamBuilder<bool>(
            initialData: true,
            stream: bloc.isTOP,
            builder: (context, snapshot) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: snapshot.data ? 6:0,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [Colors.grey.withOpacity(0.20), Colors.transparent],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 0.8),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                  )
                ),
              );
            }
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: bloc.init,
        child: ListView(
          controller: bloc.scrollCtrl,
          children: <Widget>[
            StreamBuilder<List<Banners>>(
              stream: bloc.getBanners,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CarouselSlider(
                    height: hp(25),
                    viewportFraction: 0.83,
                    autoPlay: true,
                    autoPlayInterval: const Duration(milliseconds: 10850),
                    autoPlayAnimationDuration: const Duration(milliseconds: 1850),
                    enlargeCenterPage: true,
                    items: snapshot.data.map((banner) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () => bloc.onTapBanner(banner.idCategory),
                          child: bannerSlide(banner.bannerImage)
                        ),
                      );
                    }).toList(),
                  );
                }else {
                  return SizedBox(height: hp(25), width: double.infinity, child: LoadingBlock(Theme.of(context).primaryColor));
                }
              }
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Text(allTranslations.text("OUR_SERVICE"), style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: StreamBuilder<List<Categories>>(
                stream: bloc.getCategories,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("Regular", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                            SizedBox(height: 5),
                          ]..addAll(List.generate(3, (i) => menuButton(
                            imageUrl: snapshot.data[i].categoryImage,
                            title: snapshot.data[i].categoryDesc,
                            isPremium: false,
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductListPage(snapshot.data[i], "yes", "yes")))
                          )).toList()),
                        ),
                        Column(
                          children: <Widget>[
                            Text("PP/Harian", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                            SizedBox(height: 5),
                          ]..addAll(List.generate(3, (i) => menuButton(
                            imageUrl: snapshot.data[i].categoryImage,
                            title: snapshot.data[i].categoryDesc,
                            isPremium: false,
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductListPage(snapshot.data[i], "no", "yes")))
                          )).toList()),
                        ),
                        Column(
                          children: <Widget>[
                            Text("Online", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                            SizedBox(height: 5),
                          ]..addAll(List.generate(3, (i) => menuButton(
                            imageUrl: snapshot.data[i].categoryImage,
                            title: snapshot.data[i].categoryDesc,
                            isPremium: false,
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductListPage(snapshot.data[i], "all", "no")))
                          )).toList()),
                        ),
                        
                      ],
                    );
                  }
                  return LoadingBlock(Theme.of(context).primaryColor);
                }
              ), 
            ),
            StreamBuilder<bool>(
              initialData: false,
              stream: bloc.isExpanded,
              builder: (context, snapshot) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: !snapshot.data ? 0.0:null,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: StreamBuilder<List<Categories>>(
                    stream: bloc.getCategories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: List.generate(snapshot.data.length -3, (i) => menuButton(
                                imageUrl: snapshot.data[i+3].categoryImage,
                                title: snapshot.data[i+3].categoryDesc,
                                isPremium: false,
                                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductListPage(snapshot.data[i+3], "yes", "yes")))
                              )).toList(),
                            ),
                            Column(
                              children: List.generate(snapshot.data.length -3, (i) => menuButton(
                                imageUrl: snapshot.data[i+3].categoryImage,
                                title: snapshot.data[i+3].categoryDesc,
                                isPremium: false,
                                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductListPage(snapshot.data[i+3], "no", "yes")))
                              )).toList(),
                            ),
                            Column(
                              children: List.generate(snapshot.data.length -3, (i) => menuButton(
                                imageUrl: snapshot.data[i+3].categoryImage,
                                title: snapshot.data[i+3].categoryDesc,
                                isPremium: false,
                                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductListPage(snapshot.data[i+3], "all", "no")))
                              )).toList(),
                            ),
                            
                          ],
                        );
                      }
                      return LoadingBlock(Theme.of(context).primaryColor);
                    }
                  ), 
                );
              }
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<bool>(
                initialData: false,
                stream: bloc.isExpanded,
                builder: (context, snapshot) {
                  return FlatButton(
                    child: Text(!snapshot.data ? "Selengkapnya":"Sembunyikan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                    onPressed: () => bloc.setExpanded(!snapshot.data),
                  );
                }
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
                  child: Row(
                    children: <Widget>[
                      Text(allTranslations.text("NEW_UPDATE"), style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                StreamBuilder<List<Promote>>(
                  stream: bloc.getPromotes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data.map((promote) => InkWell(
                          onTap: () => navService.navigateTo("/news-detail", promote),
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
                      );
                    } return SizedBox(
                      height: 200,
                      child: Center(
                        child: LoadingBlock(Theme.of(context).primaryColor),
                      ),
                    );
                  }
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}