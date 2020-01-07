import 'dart:convert';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/session.dart';
import 'package:http/http.dart' show Client, Response;

class Api {
  Client client = new Client();
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<Response> get(String _endpoint, {String endpoint, bool auth = false}) async {
    var token = await sessions.load("token");
    String authorization = (auth && token != null ? "/$token":"") + (endpoint != null ? "/$endpoint":"") + "?lang=${allTranslations.currentLanguage}";
    return client.get("http://api.housesolutionsindonesia.com/api/v1$_endpoint$authorization", headers: requestHeaders);
  }
  
  Future<Response> post(String _endpoint, {String endpoint, bool auth = false, Map<String, dynamic> body, String ver = "v1"}) async {
    var token = await sessions.load("token");
    String authorization = (auth && token != null ? "/$token":"") + (endpoint != null ? "/$endpoint":"") + "?lang=${allTranslations.currentLanguage}";
    print("http://api.housesolutionsindonesia.com/api/$ver$_endpoint$authorization");
    return client.post("http://api.housesolutionsindonesia.com/api/$ver$_endpoint$authorization", headers: requestHeaders, body: jsonEncode(body));
  }
  
  Future<Response> FCM(Map<String, dynamic> body) async {
    requestHeaders['Authorization'] = "key=AAAAmcWLN8Q:APA91bFuuSkllrGOHoK_T6TlKjzTXrDfZ5-rZPjCqe5rz8FA7eAHwbXIhCpaInlYM40mRu9_WpdJ8a2zynN3ScTwqeyEcocBVyrwvEjd6tmfqAu8evd2oy7ENtOYasmNW-jD29NWegZ2";
    return await client.post("https://fcm.googleapis.com/fcm/send", headers: requestHeaders, body: jsonEncode(body));
  }
  Future<Response> getPure(String endpoint) async {
    return await client.get(endpoint);
  }

  void cancel() {
    client?.close();
    client = new Client();
  }
  String getContent(String data) {
    var result = jsonDecode(data)['message'];
    return result.runtimeType == String ? result : jsonEncode(result);
  }
}
final api = new Api();