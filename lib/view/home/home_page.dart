import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/home_bloc.dart';
import 'package:housesolutions/model/banner.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/promote.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/view/product/product_list_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:responsive_screen/responsive_screen.dart';

class HomePage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  Widget menuButton({@required String imageUrl, @required String title, void Function() onPressed}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 80,
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 50, height: 50,
                child: Image.asset(
                  imageUrl,
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
      appBar: PreferredSize(
        child: Container(

          child: StreamBuilder<User>(
            stream: bloc.getUser,
            builder: (context, snapshot) {
              return Center(child: Text(snapshot.hasData ? "Hai, ${snapshot.data.customerName}":allTranslations.text("WELCOME"), style: TextStyle(color: Colors.white, fontSize: 22)));
            }
          ),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(R.assetsImagesHeader), fit: BoxFit.fitWidth)
          ),
        ),
        preferredSize: Size.fromHeight(100)
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: RefreshIndicator(
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
                            // onTap: () => bloc.onTapBanner(banner.idCategory),
                            onTap: () => null,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: [
                        menuButton(
                          imageUrl: R.assetsImagesOnline,
                          title: "Mitra Online",
                          onPressed: () => navService.navigateTo("/product-category", "online")
                        ),
                        menuButton(
                          imageUrl: R.assetsImagesJobInform,
                          title: "Request Pekerja",
                          onPressed: () => navService.navigateTo("/job-list")
                        ),
                        menuButton(
                          imageUrl: R.assetsImagesHealty,
                          title: "Solusi Kesehatan",
                          onPressed: () => navService.navigateTo("/news-list", 2)
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        menuButton(
                          imageUrl: R.assetsImagesPp,
                          title: "Mitra PP/Harian",
                          onPressed: () => navService.navigateTo("/product-category", "pp")
                        ),
                        menuButton(
                          imageUrl: R.assetsImagesNews,
                          title: "News",
                          onPressed: () => navService.navigateTo("/promote-list")
                        ),
                        menuButton(
                          imageUrl: R.assetsImagesFamily,
                          title: "Solusi Keluarga",
                          onPressed: () => navService.navigateTo("/news-list", 3)
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        menuButton(
                          imageUrl: R.assetsImagesRegular,
                          title: "Mitra Regular",
                          onPressed: () => navService.navigateTo("/product-category", "regular")
                        ),
                        menuButton(
                          imageUrl: R.assetsImagesKitchen,
                          title: "Solusi Dapur",
                          onPressed: () => navService.navigateTo("/news-list", 1)
                        ),
                        menuButton(
                          imageUrl: R.assetsImagesNotification,
                          title: "Info",
                          onPressed: () => navService.navigateTo("/notification")
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}