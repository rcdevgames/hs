import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/home_bloc.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/bloc/user_bloc.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';
import 'package:housesolutions/view/home/home_page.dart';
import 'package:housesolutions/view/home/order_page.dart';
import 'package:housesolutions/view/home/user_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final _key = GlobalKey<ScaffoldState>();
  final bloc = BlocProvider.getBloc<LayoutBloc>();
  final homeBloc = BlocProvider.getBloc<HomeBloc>();
  final orderBloc = BlocProvider.getBloc<OrderBloc>();
  final userBloc = BlocProvider.getBloc<UserBloc>();

  final pages = [
    new HomePage(),
    new OrderPage(),
    new UserPage()
  ];

  @override
  void initState() { 
    super.initState();
    homeBloc.init();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    homeBloc.disposed();
    orderBloc.disposed();
    userBloc.disposed();
    bloc.setIndex(0);
  }

  init() async {
    var loggedIn = await sessions.checkAuth();
    if (loggedIn) {
      orderBloc.fetchOrders();
      orderBloc.fetchOwnWorker();
      orderBloc.fetchSummary();
      userBloc.fetchUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: StreamBuilder<int>(
        initialData: 0,
        stream: bloc.getIndex,
        builder: (context, snapshot) {
          return pages[snapshot.data];
        }
      ),
      bottomNavigationBar: StreamBuilder<int>(
        initialData: 0,
        stream: bloc.getIndex,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            onTap: bloc.setIndex,
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

class LayoutBloc extends BlocBase {
  final _index = BehaviorSubject<int>.seeded(0);
  Stream<int> get getIndex => _index.stream;
  void setIndex(int index) async {
    if (index > 0) {
      var loggedIn = await sessions.checkAuth();
      if (!loggedIn) {
        navService.navigateTo("/login");
        return;
      }
    }
    _index.sink.add(index);
  }

}