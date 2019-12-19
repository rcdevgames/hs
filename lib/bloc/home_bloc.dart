import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/model/banner.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/promote.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  ScrollController scrollCtrl;

  final _categories = BehaviorSubject<List<Categories>>();
  final _banner = BehaviorSubject<List<Banners>>();
  final _promote = BehaviorSubject<List<Promote>>();
  final _user = BehaviorSubject<User>();
  final _loading = BehaviorSubject<bool>.seeded(false);
  final _top = BehaviorSubject<bool>.seeded(false);

  //Initialize
  HomeBloc(){
    scrollCtrl = new ScrollController();
    scrollCtrl.addListener(scrollListener);
    init();
  }

  @override
  void dispose() { 
    super.dispose();
    _categories.close();
    _banner.close();
    _promote.close();
    _user.close();
    _loading.close();
    _top.close();
  }

  //Getter
  Stream<List<Categories>> get getCategories => _categories.stream;
  Stream<List<Banners>> get getBanners => _banner.stream;
  Stream<List<Promote>> get getPromotes => _promote.stream;
  Stream<User> get getUser => _user.stream;
  Stream<bool> get isLoading => _loading.stream;
  Stream<bool> get isTOP => _top.stream;

  //Setter
  Function(List<Categories>) get setCategories => _categories.sink.add;
  Function(List<Banners>) get setBanners => _banner.sink.add;
  Function(List<Promote>) get setPromotes => _promote.sink.add;
  Function(User) get setUser => _user.sink.add;
  Function(bool) get setLoading => _loading.sink.add;
  Function(bool) get setTOP => _top.sink.add;

  //Function
  Future init() async {
    var loggedIn = await sessions.checkAuth();
    if (loggedIn) fetchUser();
    fetchBanner();
    fetchCategory();
    fetchPromote();
  }
  void scrollListener() {
    if(scrollCtrl.offset > 10) {
      setTOP(true);
    }else{
      setTOP(false);
    }
  }
  Future fetchBanner() async {
    try {
      var result = await repo.fetchBanner();
      setBanners(result);
      print(result.toString());
    } catch (e) {
      _banner.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }
  Future fetchPromote() async {
    try {
      var result = await repo.fetchPromote();
      setPromotes(result);
      print(result.toString());
    } catch (e) {
      _promote.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }
  Future fetchCategory() async {
    try {
      var result = await repo.fetchCategory();
      setCategories(result);
      print(result.toString());
    } catch (e) {
      _categories.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }
  Future fetchUser() async {
    try {
      var logged_in = await sessions.checkAuth();
      if (logged_in) setUser(await repo.getUser());
    } catch (e) {
      if (e.toString().contains("Unauthorized")){
        sessions.clear();
        await navService.navigateReplaceTo("/main");
        navService.navigateTo("/login");
      }
      print(e.toString().replaceAll("Exception: ", ""));
    }
  }
  void onTapBanner(int idCategory) async {
    if (_categories.hasValue) {
      var auth = await sessions.checkAuth();
      if (idCategory != null || auth) {
        navService.navigateTo("/product-list", _categories.value.firstWhere((i) => i.idCategory == idCategory));
      }
    }
  }

}