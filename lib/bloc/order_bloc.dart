import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cryptoutils/cryptoutils.dart';
import 'package:flutrans/flutrans.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/model/bank.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:housesolutions/model/own_worker.dart';
import 'package:housesolutions/model/payment.dart';
import 'package:housesolutions/model/payment_detail.dart';
import 'package:housesolutions/model/summary.dart' as prefix0;
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';
import 'package:housesolutions/view/home/layout.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class OrderBloc extends BlocBase {
  final _summary = BehaviorSubject<prefix0.Summary>();
  final _orders = BehaviorSubject<List<Payment>>();
  final _workers = BehaviorSubject<List<OwnWorkers>>();
  final _loading = BehaviorSubject<bool>.seeded(false);
  final _tab = BehaviorSubject<int>.seeded(0);
  final _worker = BehaviorSubject<MyWorker>();
  final _reason = BehaviorSubject<String>();
  final _paymentDetail = BehaviorSubject<PaymentDetail>();
  final _banks = BehaviorSubject<List<Bank>>();
  final _path = BehaviorSubject<String>();
  final _image = BehaviorSubject<File>();
  final _paymentMethod = BehaviorSubject<String>();
  final _radio = BehaviorSubject<String>.seeded("m");
  final _totalDay = BehaviorSubject<int>();

  @override
  void dispose() { 
    super.dispose();
    _summary.close();
    _orders.close();
    _workers.close();
    _loading.close();
    _tab.close();
    _worker.close();
    _reason.close();
    _paymentDetail.close();
    _banks.close();
    _path.close();
    _image.close();
    _paymentMethod.close();
    _radio.close();
    _totalDay.close();
  }

  void disposed() {
    _summary.sink.add(null);
    _orders.sink.add(null);
    _workers.sink.add(null);
    _loading.sink.add(false);
    _tab.sink.add(0);
    _worker.sink.add(null);
    _reason.sink.add(null);
    _paymentDetail.sink.add(null);
    _banks.sink.add(null);
    _path.sink.add(null);
    _image.sink.add(null);
    _paymentMethod.sink.add(null);
    _radio.sink.add("m");
    _totalDay.sink.add(null);
  }

  //Getter
  Stream<prefix0.Summary> get getSummary => _summary.stream;
  Stream<List<Payment>> get getOrders => _orders.stream;
  Stream<List<OwnWorkers>> get getWorkers => _workers.stream;
  Stream<MyWorker> get getWorker => _worker.stream;
  Stream<int> get getTAB => _tab.stream;
  Stream<bool> get isLoading => _loading.stream;
  Stream<PaymentDetail> get getPaymentDetail => _paymentDetail.stream;
  Stream<List<Bank>> get getBanks => _banks.stream;
  Stream<String> get getPath => _path.stream;
  Stream<File> get getImage => _image.stream;
  Stream<String> get getPaymnetMethod => _paymentMethod.stream;
  Stream<String> get getRadio => _radio.stream;
  Stream<int> get getTotalDay => _totalDay.stream;

  //Setter
  Function(prefix0.Summary) get setSummary => _summary.sink.add;
  Function(List<Payment>) get setOrders => _orders.sink.add;
  Function(List<OwnWorkers>) get setWorkers => _workers.sink.add;
  Function(MyWorker) get setWorker => _worker.sink.add;
  Function(int) get setTAB => _tab.sink.add;
  Function(bool) get setLoading => _loading.sink.add;
  Function(String) get setReason => _reason.sink.add;
  Function(PaymentDetail) get setPaymentDetail => _paymentDetail.sink.add;
  Function(List<Bank>) get setBank => _banks.sink.add;
  Function(String) get setPath => _path.sink.add;
  Function(File) get setImage => _image.sink.add;
  Function(String) get setPaymentMethod => _paymentMethod.sink.add;
  Function(String) get setRadio => _radio.sink.add;
  Function(int) get setTotalDay => _totalDay.sink.add;

  //Function
  Future fetchBank() async {
    try {
      var result = await repo.fetchBank();
      setBank(result);
    } catch (e) {
      print("Bank : ${e.toString().replaceAll("Exception: ", "")}");
      _banks.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }  
  }

  Future fetchOrders() async {
    try {
      var result = await repo.fetchPayment();
      setOrders(result);
    } catch (e) {
      print("Orders : ${e.toString().replaceAll("Exception: ", "")}");
      if (e.toString().contains("Unauthorized")) {
        sessions.clear();
        return navService.navigateReplaceTo("/login", "unauthorized");
      }
      _orders.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future fetchOwnWorker() async {
    try {
      var result = await repo.fetchMyWorkers();
      setWorkers(result);
    } catch (e) {
      print("Workers : ${e.toString().replaceAll("Exception: ", "")}");
      if (e.toString().contains("Unauthorized")) {
        sessions.clear();
        return navService.navigateReplaceTo("/login", "unauthorized");
      }
      _workers.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future fetchSummary() async {
    try {
      var result = await repo.getSummary();
      setSummary(result);
    } catch (e) {
      print("Summary : ${e.toString().replaceAll("Exception: ", "")}");
      if (e.toString().contains("Unauthorized")) {
        sessions.clear();
        return navService.navigateReplaceTo("/login", "unauthorized");
      }
      _summary.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future loadWorker(int id) async {
    try {
      var result = await repo.getMyWorker(id);
      setWorker(result);
    } catch (e) {
      print("Worker : ${e.toString().replaceAll("Exception: ", "")}");
      if (e.toString().contains("Unauthorized")) {
        sessions.clear();
        return navService.navigateReplaceTo("/login", "unauthorized");
      }
      _worker.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future fetchPayment(int idOrder) async {
    try {
      var result = await repo.getPayment(idOrder);
      if (result.transApprovalUploaded == null) {
        fetchBank();
      }
      setPaymentDetail(result);
    } catch (e) {
      print("Worker : ${e.toString().replaceAll("Exception: ", "")}");
      if (e.toString().contains("Unauthorized")) {
        sessions.clear();
        return navService.navigateReplaceTo("/login", "unauthorized");
      }
      _paymentDetail.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  void doOrder(BuildContext context, int idWorker, int idCategory) async {
    if (_paymentMethod.value != "tf" || _paymentMethod.value != "midtrans") {
      return showAlert(
        context: context, 
        title: "Transaksi tidak dapat diperoses",
        body: "Pilih Metode Pembayaran anda!"
      );
    }
    navService.navigateTo("/process-payment");
    setLoading(true);
    try {
      var result = await repo.requestWorker(idWorker, idCategory, _totalDay.value);
      await fetchOrders();
      setLoading(false);
      showAlert(
        context: context,
        title: "Order Success",
        body: result,
        barrierDismissible: false,
        actions: [
          AlertAction(
            text: "Confirm",
            onPressed: () {
              var bloc = BlocProvider.getBloc<LayoutBloc>();
              bloc.setIndex(1);
              navService.navigatePopUntil("/main");
            }
          )
        ]
      );
    } catch (e) {
      setLoading(false);
      print("doOrder : ${e.toString().replaceAll("Exception: ", "")}");
      if (e.toString().contains("Unauthorized")) {
        sessions.clear();
        return navService.navigateReplaceTo("/login", "unauthorized");
      }
      showAlert(
        context: context,
        title: "Order Error",
        body: e.toString().replaceAll("Exception: ", "")
      );
    }
  }

  void requestChangeWorker(GlobalKey<FormState> key, ) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      setLoading(true);
      try {
        var result = await repo.changeWorker(int.tryParse(_worker.value.idTrans), _worker.value.idCworker, _reason.value);
        setLoading(false);
        showAlert(
          context: key.currentContext,
          title: "Order Success",
          body: result,
          barrierDismissible: false,
          actions: [
            AlertAction(
              text: "Confirm",
              onPressed: () {
                var bloc = BlocProvider.getBloc<LayoutBloc>();
                bloc.setIndex(1);
                navService.navigatePopUntil("/main");
              }
            )
          ]
        );
      } catch (e) {
        setLoading(false);
        print("Request Change Worker : ${e.toString().replaceAll("Exception: ", "")}");
        if (e.toString().contains("Unauthorized")) {
          sessions.clear();
          return navService.navigateReplaceTo("/login", "unauthorized");
        }
        showAlert(
          context: key.currentContext,
          title: "Order Error",
          body: e.toString().replaceAll("Exception: ", "")
        );
      }
    }
  }

  void uploadImage(BuildContext context, int idTrans, ImageSource source) async {
    var file = await ImagePicker.pickImage(source: source, imageQuality: 40);
    if (file != null) {
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = CryptoUtils.bytesToBase64(imageBytes);
      setLoading(true);
      try {
        var result = await repo.uploadApproval(idTrans, base64Image);
        await fetchPayment(idTrans);
        setLoading(false);
        showAlert(
          context: context,
          title: "Upload Image Success",
          body: result
        );
      } catch (e) {
        setLoading(false);
        print("Upload Bukti Pembayaran : ${e.toString().replaceAll("Exception: ", "")}");
        showAlert(
          context: context,
          title: "Upload Image Error",
          body: e.toString().replaceAll("Exception: ", "")
        );
      }
    }
  }

  void openPDF(BuildContext context, PaymentDetail data) async {
    setLoading(true);
    var pdf = await createFileOfPdfUrl("${data.invoice}/${await sessions.load("token")}");
    Map<String, String> ref = {"path": pdf.path, "id_order": data.transId};
    setLoading(false);
    print({"path": pdf.path, "id_order": data.idTrans});
    navService.navigateTo("/invoice", ref);
  }

  Future<File> createFileOfPdfUrl(String url) async {
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  void payMidtrans(User userData, ) async {
    final flutrans = Flutrans();
    
    //Init the client ID you URL base
    flutrans.init("YOUR_CLIENT_ID", "YOUR_URL_BASE", env: "sandbox");

    //Setup the callback when payment finished
    flutrans.setFinishCallback((finished) {
        //finished is TransactionFinished
    });

    //Make payment
    flutrans
    .makePayment(
        MidtransTransaction(
            7500,
            MidtransCustomer(userData.customerName.split("")[0], userData.customerName.split("")[userData.customerName.split("").length -1], userData.customerEmail, userData.customerHandphone),
            <MidtransItem>[
              MidtransItem(
                  "5c18ea1256f67560cb6a00cdde3c3c7a81026c29",
                  7500,
                  2,
                  "USB FlashDisk",
              )
            ],
            skipCustomer: false,
            customField1: "ANYCUSTOMFIELD"),
    )
    .catchError((err) => print("ERROR $err"));
  }

}