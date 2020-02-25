import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/model/category_news_model.dart';
import 'package:housesolutions/model/news_detail_model.dart';
import 'package:housesolutions/model/news_model.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc extends BlocBase {
  List<TextEditingController> ctrl_sub = [];

  final _list_category = BehaviorSubject<List<CategoryNews>>();
  final _list_news = BehaviorSubject<List<News>>();
  final _news = BehaviorSubject<NewsDetail>();
  final _loading = BehaviorSubject<bool>.seeded(false);

  //Initialize
  NewsBloc(){
    fetchCategoryNews();
  }

  @override
  void dispose() { 
    super.dispose();
    _list_category.close();
    _list_news.close();
    _news.close();
    _loading.close();
  }

  //Getter
  Stream<List<CategoryNews>> get getCategoryNews => _list_category.stream;
  Stream<List<News>> get getNews => _list_news.stream;
  Stream<NewsDetail> get getDetailNews => _news.stream;
  Stream<bool> get isLoading => _loading.stream;

  //Setter
  Function(List<CategoryNews>) get setCategoryNews => _list_category.sink.add;
  Function(List<News>) get setNews => _list_news.sink.add;
  Function(NewsDetail) get setDetailNews => _news.sink.add;
  Function(bool) get setLoading => _loading.sink.add;

  //Function
  Future fetchCategoryNews() async {
    try {
      final result = await repo.fetchCategoryNews();
      setCategoryNews(result);
    } catch (e) {
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      _list_category.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future fetchNews(int id) async {
    try {
      final result = await repo.fetchNews(id);
      setNews(result);
    } catch (e) {
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      _list_news.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future fetchDetailNews(String slug) async {
    try {
      final result = await repo.getDetailNews(slug);
      ctrl_sub = List.generate(result.comments.length, (i) => TextEditingController());
      setDetailNews(result);
    } catch (e) {
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      _list_news.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  doComment(BuildContext context, String slug, int id, String message, TextEditingController ctrl) async {
    setLoading(true);
    try {
      final result = await repo.doComment(id, message);
      await fetchDetailNews(slug);
      setLoading(false);
      ctrl.clear();
    } catch (e) {
      setLoading(false);
      showAlert(
        context: context,
        title: "Terjadi Kesalahan",
        body: e.toString().replaceAll("Exception: ", "")
      );
    }
  }

  doSubComment(BuildContext context, String slug, int id, int idComment, String message, TextEditingController ctrl) async {
    setLoading(true);
    try {
      final result = await repo.doSubComment(id, idComment, message);
      await fetchDetailNews(slug);
      setLoading(false);
      ctrl.clear();
    } catch (e) {
      setLoading(false);
      showAlert(
        context: context,
        title: "Terjadi Kesalahan",
        body: e.toString().replaceAll("Exception: ", "")
      );
    }
  }

}