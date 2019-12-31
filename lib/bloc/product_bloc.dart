import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/model/search_worker.dart';
import 'package:housesolutions/model/worker.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  final _list_worker = BehaviorSubject<SearchWorker>();
  final _provinces = BehaviorSubject<List<Province>>();
  final _districts = BehaviorSubject<List<District>>();
  final _province = BehaviorSubject<int>();
  final _district = BehaviorSubject<int>();
  final _worker = BehaviorSubject<Worker>();
  final _place = BehaviorSubject<String>();
  final _rating = BehaviorSubject<List<double>>.seeded([0.0,0.0]);
  final _salary = BehaviorSubject<List<double>>.seeded([0.0,0.0]);
  final _loading = BehaviorSubject<bool>.seeded(false);

  @override
  void dispose() { 
    super.dispose();
    _list_worker.close();
    _provinces.close();
    _districts.close();
    _province.close();
    _district.close();
    _worker.close();
    _place.close();
    _rating.close();
    _salary.close();
    _loading.close();
  }

  //Getter
  Stream<SearchWorker> get getWorkers => _list_worker.stream;
  Stream<List<Province>> get getProvinces => _provinces.stream;
  Stream<List<District>> get getDistricts => _districts.stream;
  Stream<int> get getProvince => _province.stream;
  Stream<int> get getDistrict => _district.stream;
  Stream<Worker> get getWorker => _worker.stream;
  Stream<List<double>> get getRating => _rating.stream;
  Stream<List<double>> get getSalary => _salary.stream;
  Stream<String> get getPlace => _place.stream;
  Stream<bool> get isLoading => _loading.stream;



  //Setter
  Function(int) get setProvince => _province.sink.add;
  Function(int) get setDistrict => _district.sink.add;
  Function(List<double>) get setRating => _rating.sink.add;
  Function(List<double>) get setSalary => _salary.sink.add;
  Function(String) get setPlace => _place.sink.add;
  Function(bool) get setLoading => _loading.sink.add;
  Function(SearchWorker) get setWorkers => _list_worker.sink.add;
  Function(Worker) get setWorker => _worker.sink.add;

  //Function
  Future fetchWorker(int idCategory, String stayIn, String regular, [int page = 1]) async {
    try {
      var result = await repo.fetchSearchWorkers(
        idCategory, 
        _province.value, 
        _district.value,
        page: page,
        startRating: _rating.value[0],
        endRating: _rating.value[1],
        startSalary: _salary.value[0].toInt(),
        endSalary: _salary.value[1].toInt(),
        stayIn: stayIn,
        regular: regular
      );
      
      if (result != null && result.page > 1) {
        setWorkers(SearchWorker(
          page: result.page,
          limit: result.limit,
          paging: result.paging,
          data: _list_worker.value.data + result.data
        ));
      }else{
        setWorkers(result);
      }
    } catch (e) {
      print("Fetch Search Worker : ${e.toString().replaceAll("Exception: ", "")}");
      _list_worker.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future workerDetail(int idWorker) async {
    try {
      var result = await repo.getSearchWorker(idWorker);
      setWorker(result);
    } catch (e) {
      print("Worker DEtail : ${e.toString().replaceAll("Exception: ", "")}");
      _worker.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

}