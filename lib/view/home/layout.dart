import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/home_bloc.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/view/home/home_page.dart';
import 'package:housesolutions/view/home/order_page.dart';
import 'package:housesolutions/view/home/user_page.dart';

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<HomeBloc>();
  final pages = [
    new HomePage(),
    new OrderPage(),
    new UserPage()
  ];

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: StreamBuilder<int>(
        initialData: 0,
        stream: null,
        builder: (context, snapshot) {
          return pages[snapshot.data];
        }
      ),
      bottomNavigationBar: StreamBuilder<int>(
        initialData: 0,
        stream: null,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            onTap: (i) => null,
            currentIndex: snapshot.data,
            items: [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                title: Text(allTranslations.text("HOME"))
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidListAlt),
                title: Text(allTranslations.text("TRANSACTION"))
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.userAlt),
                title: Text(allTranslations.text("PROFILE"))
              ),
            ],
          );
        }
      ),
    );
  }
}