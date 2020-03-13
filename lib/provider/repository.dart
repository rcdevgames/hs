import 'package:housesolutions/model/bank.dart';
import 'package:housesolutions/model/banner.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/model/category_complaint_model.dart';
import 'package:housesolutions/model/category_news_model.dart';
import 'package:housesolutions/model/complaint_model.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/facebook.dart';
import 'package:housesolutions/model/job_inform_model.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:housesolutions/model/news_detail_model.dart';
import 'package:housesolutions/model/news_model.dart';
import 'package:housesolutions/model/notice_model.dart';
import 'package:housesolutions/model/notification.dart';
import 'package:housesolutions/model/order_result.dart';
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
import 'package:housesolutions/util/api.dart';

import 'auth_provider.dart';
import 'banner_provider.dart';
import 'category_provider.dart';
import 'complaint_provider.dart';
import 'config_provider.dart';
import 'notification_provider.dart';
import 'order_provider.dart';
import 'news_provider.dart';
import 'product_provider.dart';
import 'promote_provider.dart';
import 'region_provider.dart';
import 'user_provider.dart';
import 'job_provider.dart';

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
  Future<OrderResult> requestWorker(int idWorker, int idCategory, [int total_day = 0, String payment_method = 'tf']) => orderProvider.requestWorker(idWorker, idCategory, total_day, payment_method);
  Future<String> uploadApproval(int idTrans, String image64) => orderProvider.uploadApproval(idTrans, image64);
  Future<String> changeWorker(int idTrans, int idWorker, String reason) => orderProvider.changeWorker(idTrans, idWorker, reason);
  Future<List<Transaction>> fetchWorkerOrder() => orderProvider.fetchWorkerOrder();
  Future<PaymentDetail> getPayment(int id) => orderProvider.getPayment(id);
  Future<List<Bank>> fetchBank() => orderProvider.fetchBank();
  Future<String> setArrivedWorker(int idTrans) => orderProvider.setArrivedWorker(idTrans);

  final complaintProvider = new ComplaintProvider();
  Future<List<ComplaintCategory>> fetchComplaintCategory() => complaintProvider.fetchComplaintCategory();
  Future<List<Complaints>> fetchComplaint() => complaintProvider.fetchComplaint();
  Future<Complaints> getComplaint(int id) => complaintProvider.getComplaint(id);
  Future<String> createComplaint(int id_category, String title, String message) => complaintProvider.createComplaint(id_category, title, message);
  Future<String> replyComplaint(int id, String message) => complaintProvider.replyComplaint(id, message);

  final notificationProvider = new NotificationProvider();
  Future<List<Notifications>> fetchNotification() => notificationProvider.fetchNotification();
  Future pushFCM(List<String> to, String title, String message) => notificationProvider.pushFCM(to, title, message);
  Future<Notice> getNoticeDetail(int id) => notificationProvider.getNoticeDetail(id);

  final productProvider = new ProductProvider();
  Future<SearchWorker> fetchSearchWorkers(int idCategory, int idProvince, int idDistrict, {int page = 1, int startSalary = 0, int endSalary = 0, num startRating = 0, num endRating = 0, stayIn = "all", regular = "all"}) => productProvider.fetchSearchWorkers(idCategory, idProvince, idDistrict, page, startSalary, endSalary, startRating, endRating, stayIn, regular);
  Future<Worker> getSearchWorker(int idWorker) => productProvider.getWorker(idWorker);

  final newsProvider = new NewsProvider();
  Future<List<CategoryNews>> fetchCategoryNews() => newsProvider.fetchCategoryNews();
  Future<List<News>> fetchNews(int id, [int page = 1]) => newsProvider.fetchNews(id, page);
  Future<NewsDetail> getDetailNews(String slug) => newsProvider.getDetailNews(slug);
  Future<String> doComment(int id, String message) => newsProvider.doComment(id, message);
  Future<String> doSubComment(int id, int idComment, String message) => newsProvider.doSubComment(id, idComment, message);

  final jobProvider = new JobProvider();
  Future<List<JobInform>> fetchJobList() => jobProvider.fetchJobList();
  Future<String> createJob(int id_category, String title, String desc, String placement) => jobProvider.createJob(id_category, title, desc, placement);
  Future<String> statusJob(int id, bool active) => jobProvider.statusJob(id, active);
}

final repo = new Repository();