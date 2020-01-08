import 'package:housesolutions/model/bank.dart';
import 'package:housesolutions/model/banner.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/complaint.dart';
import 'package:housesolutions/model/complaint_category.dart';
import 'package:housesolutions/model/complant_single.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/facebook.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:housesolutions/model/notification.dart';
import 'package:housesolutions/model/own_worker.dart';
import 'package:housesolutions/model/payment.dart';
import 'package:housesolutions/model/payment_detail.dart';
import 'package:housesolutions/model/promote.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/model/search_worker.dart';
import 'package:housesolutions/model/summary.dart';
import 'package:housesolutions/model/transaction.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/model/worker.dart';
import 'package:housesolutions/provider/product_provider.dart';
import 'package:housesolutions/provider/promote_provider.dart';
import 'package:housesolutions/provider/region_provider.dart';
import 'package:housesolutions/provider/user_provider.dart';
import 'package:housesolutions/util/api.dart';

import 'auth_provider.dart';
import 'banner_provider.dart';
import 'category_provider.dart';
import 'complaint_provider.dart';
import 'config_provider.dart';
import 'notification_provider.dart';
import 'order_provider.dart';

class Repository {
  // Cancel Transaction HTTP
  void cancel() => api.cancel();

  final authProvider = new AuthProvider();
  Future<bool> checkLogin(String email) => authProvider.checkLogin(email);
  Future<bool> doLogin(String email, String password) => authProvider.doLogin(email, password);
  Future<bool> doLoginSocmed(String email, String appId, String via) => authProvider.doLoginSocmed(email, appId, via);
  Future<Facebook> userFacebook(String token) => authProvider.userFacebook(token);
  Future<String> doRegister(num idDistrict, num idProvince, String name, String email, String password, String phone, String address, [DateTime birthdate, int category]) => authProvider.doRegister(idDistrict, idProvince, name, email, password, phone, address, birthdate, category);
  Future<String> changePassword(String oldPassword, String newPassword) => authProvider.changePassword(oldPassword, newPassword);
  Future<String> forgotPassword(String email, {bool customer = true}) => authProvider.forgotPassword(email, customer);
  Future logout() => authProvider.logout();

  final userProvider = new UserProvider();
  Future<User> getUser() => userProvider.getCustomer();
  Future<String> updateProfile(int idProvince, int idDistrict, String name, String email, String handphone, String address, String image) => userProvider.updateProfile(idProvince, idDistrict, name, email, handphone, address, image);

  final categoryProvider = new CategoryProvider();
  Future<List<Categories>> fetchCategory() => categoryProvider.fetchCategory();

  final bannerProvider = new BannerProvider();
  Future<List<Banners>> fetchBanner() => bannerProvider.fetchBanner();

  final regionProvider = new RegionProvider();
  Future<List<Province>> fetchProvince() => regionProvider.fetchProvince();
  Future<List<District>> fetchDistrict(num idProvince) => regionProvider.fetchDistrict(idProvince);

  final configProvider = new ConfigProvider();
  Future<String> getTNC() => configProvider.getTNC();
  Future<String> getPaymentInstruction() => configProvider.getPaymentInstruction();

  final promoteProvider = new PromoteProvider();
  Future<List<Promote>> fetchPromote() => promoteProvider.fetchPromote();

  final orderProvider = new OrderProvider();
  Future<Summary> getSummary() => orderProvider.getSummary();
  Future<List<Payment>> fetchPayment() => orderProvider.fetchPayment();
  Future<List<OwnWorkers>> fetchMyWorkers() => orderProvider.fetchMyWorkers();
  Future<MyWorker> getMyWorker(int id) => orderProvider.getMyWorker(id);
  Future<String> requestWorker(int idWorker, int idCategory, [int total_day = 0]) => orderProvider.requestWorker(idWorker, idCategory, total_day);
  Future<String> uploadApproval(int idTrans, String image64) => orderProvider.uploadApproval(idTrans, image64);
  Future<String> changeWorker(int idTrans, int idWorker, String reason) => orderProvider.changeWorker(idTrans, idWorker, reason);
  Future<List<Transaction>> fetchWorkerOrder() => orderProvider.fetchWorkerOrder();
  Future<PaymentDetail> getPayment(int id) => orderProvider.getPayment(id);
  Future<List<Bank>> fetchBank() => orderProvider.fetchBank();

  final complaintProvider = new ComplaintProvider();
  Future<List<Complaint>> fetchComplaints() => complaintProvider.fetchComplaints();
  Future<ComplaintSingle> getComplaint(int id) => complaintProvider.getComplaint(id);
  Future<List<ComplaintCategory>> fetchComplaintCategories() => complaintProvider.fetchComplaintCategories();
  Future createComplaint(int id_category, String title, String message) => complaintProvider.createComplaint(id_category, title, message);
  Future replyComplaint(int id_complaint, String message) => complaintProvider.replyComplaint(id_complaint, message);

  final notificationProvider = new NotificationProvider();
  Future<List<Notifications>> fetchNotification() => notificationProvider.fetchNotification();
  Future pushFCM(List<String> to, String title, String message) => notificationProvider.pushFCM(to, title, message);

  final productProvider = new ProductProvider();
  Future<SearchWorker> fetchSearchWorkers(int idCategory, int idProvince, int idDistrict, {int page = 1, int startSalary = 0, int endSalary = 0, num startRating = 0, num endRating = 0, stayIn = "all", regular = "all"}) => productProvider.fetchSearchWorkers(idCategory, idProvince, idDistrict, page, startSalary, endSalary, startRating, endRating, stayIn, regular);
  Future<Worker> getSearchWorker(int idWorker) => productProvider.getWorker(idWorker);
}

final repo = new Repository();