import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:housesolutions/model/notice_model.dart';
import 'package:housesolutions/model/notification.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:rxdart/rxdart.dart';

class NotificationBloc extends BlocBase {
  final _notif = BehaviorSubject<List<Notifications>>();
  final _notice = BehaviorSubject<Notice>();
  
  @override
  void dispose() { 
    super.dispose();
    _notif.close();
    _notice.close();
  }

  NotificationBloc() {
    loadNotification();
  }

  // Getter
  Stream<List<Notifications>> get getNotif => _notif.stream;
  Stream<Notice> get getNotice => _notice.stream;

  // Setter
  Function(List<Notifications>) get setNotif => _notif.sink.add;
  Function(Notice) get setNotice => _notice.sink.add;

  
  Future loadNotification() async {
    print("init notif");
    try {
      setNotif(await repo.fetchNotification());
    } catch (e) {
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      print(e.toString());
      _notif.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future getNoticeDetai(int id) async {
    try {
      setNotice(await repo.getNoticeDetail(id));
    } catch (e) {
      if (e.toString().contains("Unauthorized")) {
        return navService.navigateReplaceTo("/login", "Sesi Telah Berakhir, Silakan Login Kembali.");
      }
      print(e.toString());
      _notice.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }
}