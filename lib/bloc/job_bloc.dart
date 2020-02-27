import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/model/job_inform_model.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:rxdart/rxdart.dart';

class JobBloc extends BlocBase {
  final _job_list = BehaviorSubject<List<JobInform>>();
  final _id_category = BehaviorSubject<int>();
  final _title = BehaviorSubject<String>();
  final _desc = BehaviorSubject<String>();
  final _location = BehaviorSubject<String>();
  final _loading = BehaviorSubject<bool>.seeded(false);

  //Getter
  Stream<List<JobInform>> get getJobList => _job_list.stream;
  Stream<int> get getIdCategory => _id_category.stream;
  Stream<bool> get isLoading => _loading.stream;

  //Setter
  Function(List<JobInform>) get setJobList => _job_list.sink.add;
  Function(int) get setIdCategory => _id_category.sink.add;
  Function(String) get setTitle => _title.sink.add;
  Function(String) get setDesc => _desc.sink.add;
  Function(String) get setLocation => _location.sink.add;
  Function(bool) get setLoading => _loading.sink.add;

  //Function
  Future fetchJobList() async {
    try {
      setJobList(await repo.fetchJobList());
    } catch (e) {
      print("Fetch Job List : ${e.toString().replaceAll('Exception: ', '')}");
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      _job_list.sink.addError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  void createJob(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      setLoading(true);
      try {
        final result = await repo.createJob(_id_category.value, _title.value, _desc.value, _location.value);
        await fetchJobList();
        showAlert(
          context: key.currentContext,
          title: result,
          actions: [AlertAction(text: "Confirm", onPressed: navService.navigatePop)]
        );
      } catch (e) {
        print("Create Job : ${e.toString().replaceAll('Exception: ', '')}");
        if (e.toString().contains("Unauthorized")) {
          return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
        }
        showAlert(
          context: key.currentContext,
          title: "Buat Request Job Gagal!",
          body: e.toString().replaceAll('Exception: ', '')
        );
      }
    }
  }
  
  void statusJob(BuildContext context, int id, bool statusJob) async {
    setLoading(true);
    try {
      final result = await repo.statusJob(id, statusJob);
      await fetchJobList();
      showAlert(
        context: context,
        title: result,
        actions: [AlertAction(text: "Confirm", onPressed: navService.navigatePop)]
      );
    } catch (e) {
      print("Change Status Job : ${e.toString().replaceAll('Exception: ', '')}");
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      showAlert(
        context: context,
        title: "Ubah Status Request Job Gagal!",
        body: e.toString().replaceAll('Exception: ', '')
      );
    }
  }

}