import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/model/category_complaint_model.dart';
import 'package:housesolutions/model/complaint_model.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:rxdart/rxdart.dart';

class ComplaintBloc extends BlocBase {
  final _list = BehaviorSubject<List<Complaints>>();
  final _detail = BehaviorSubject<Complaints>();
  final _category = BehaviorSubject<List<ComplaintCategory>>();
  final _id_category = BehaviorSubject<int>();
  final _title = BehaviorSubject<String>();
  final _message = BehaviorSubject<String>();
  final _loading = BehaviorSubject<bool>.seeded(false);

  @override
  void dispose() { 
    _list.close();
    _detail.close();
    _category.close();
    _id_category.close();
    _title.close();
    _message.close();
    _loading.close();
    super.dispose();
  }

  //Getter
  Stream<List<Complaints>> get getComplaints => _list.stream;
  Stream<Complaints> get getComplaint => _detail.stream;
  Stream<List<ComplaintCategory>> get getCategory => _category.stream;
  Stream<int> get getIdCategory => _id_category.stream;
  Stream<bool> get isLoading => _loading.stream;

  //Setter
  Function(List<Complaints>) get setComplaints => _list.sink.add;
  Function(Complaints) get setComplaint => _detail.sink.add;
  Function(int) get setIdCategory => _id_category.sink.add;
  Function(String) get setTitle => _title.sink.add;
  Function(String) get setMessage => _message.sink.add;
  Function(bool) get setLoading => _loading.sink.add;

  //Function
  Future fetchCategory() async {
    try {
      final result = await repo.fetchComplaintCategory();
      _category.sink.add(result);
    } catch (e) {
      print("Fetch Category Complaints : ${e.toString().replaceAll('Exception: ', '')}");
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      _category.sink.addError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future fetchComplaints() async {
    try {
      final result = await repo.fetchComplaint();
      _list.sink.add(result);
    } catch (e) {
      print("Fetch Complaints : ${e.toString().replaceAll('Exception: ', '')}");
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      _list.sink.addError(e.toString().replaceAll('Exception: ', ''));
    }
  }
  
  Future getDetailComplaint(int id) async {
    try {
      final result = await repo.getComplaint(id);
      _detail.sink.add(result);
    } catch (e) {
      print("Fetch Detail Complaint : ${e.toString().replaceAll('Exception: ', '')}");
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      _detail.sink.addError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  void doComplaint(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();

      setLoading(true);
      try {
        final result = await repo.createComplaint(_id_category.value, _title.value, _message.value);
        await fetchComplaints();
        setLoading(false);
        showAlert(
          context: key.currentContext,
          title: "Pengajuan Komplain Berhasil!",
          body: result,
          actions: [AlertAction(text: "Confirm", onPressed: navService.navigatePop)]
        );
      } catch (e) {
        setLoading(false);
        print("Crate Complaint : ${e.toString().replaceAll('Exception: ', '')}");
        if (e.toString().contains("Unauthorized")) {
          return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
        }
        showAlert(
          context: key.currentContext,
          title: "Pengajuan Komplain Gagal!",
          body: e.toString().replaceAll('Exception: ', ''),
        );
      }
    }
  }
  
  void replyComplaint(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();

      setLoading(true);
      try {
        final result = await repo.replyComplaint(_detail.value.idComplaint, _message.value);
        await getDetailComplaint(_detail.value.idComplaint);
        setLoading(false);
        showAlert(
          context: key.currentContext,
          title: "Membalas Pesan Komplain Berhasil!",
          body: result,
          actions: [AlertAction(text: "Confirm", onPressed: navService.navigatePop)]
        );
      } catch (e) {
        setLoading(false);
        print("Crate Complaint : ${e.toString().replaceAll('Exception: ', '')}");
        if (e.toString().contains("Unauthorized")) {
          return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
        }
        showAlert(
          context: key.currentContext,
          title: "Membalas Pesan Komplain Gagal!",
          body: e.toString().replaceAll('Exception: ', ''),
        );
      }
    }
  }

}