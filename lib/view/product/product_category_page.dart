import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/home_bloc.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/view/product/product_list_page.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';

class ProductCategoryPage extends StatefulWidget {
  String type;
  ProductCategoryPage([this.type = "regular"]);

  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<HomeBloc>();

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
                  placeholder: (BuildContext context, String data) => SizedBox(child: LoadingBlock(), width: 50, height: 50),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor
        ),
        title: StreamBuilder<User>(
          stream: bloc.getUser,
          builder: (context, snapshot) {
            return Text(snapshot.hasData ? "Hai, ${snapshot.data.customerName}" : allTranslations.text("WELCOME"), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 22));
          }
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Builder(
              builder: (context) {
                if (widget.type == "pp") {
                  return Image.asset(R.assetsImagesBannerPp);
                }else if (widget.type == "online") {
                  return Image.asset(R.assetsImagesBannerOnline);
                }
                return Image.asset(R.assetsImagesBannerRegular);
              }
            ),
            SizedBox(height: 30),
            Builder(
              builder: (context) {
                if (widget.type == "pp") {
                  return Text("Mitra Harian/Bulanan Pulang-Pergi", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18));
                }else if (widget.type == "online") {
                  return Text("Mitra Online", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18));
                }
                return Text("Mitra Regular", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18));
              }
            ),
            SizedBox(height: 20),
            Flexible(
              child: StreamBuilder<List<Categories>>(
                stream: bloc.getCategories,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 4,
                      children: snapshot.data.map((category) {
                        return menuButton(
                          imageUrl: category.categoryImage, 
                          title: category.categoryDesc,
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            if (widget.type == "pp") {
                              return ProductListPage(category, "no", "yes");
                            }else if (widget.type == "online") {
                              return ProductListPage(category, "all", "no");
                            } return ProductListPage(category, "yes", "yes");
                          }))
                        );
                      }).toList(),
                    );
                  }else if (snapshot.hasError) {
                    Center(
                      child: ErrorPage(
                        message: snapshot.error, 
                        onPressed: () {
                          bloc.setCategories(null);
                          bloc.fetchCategory();
                        }, 
                        buttonText: "Ulangi"
                      ),
                    );
                  } return LoadingBlock();
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}