import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String _url = "http://192.168.43.28:3000";

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: data,
    );
  }
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    // await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      // headers: _setHeaders()
    );
  }
  deleteData(apiUrl)async{
    var fullUrl = _url + apiUrl;
    return await http.get(
        Uri.parse(fullUrl),
    );
  }
}
