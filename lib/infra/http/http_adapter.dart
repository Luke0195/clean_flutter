import 'dart:convert';

import 'package:flutter_tdd/data/http/http_error.dart';
import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client httpClient;

  const HttpAdapter({ required this.httpClient});
  
  @override
  Future<Map?> request({ required String url, required String method, Map? body}) async {
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response =  await httpClient.post(Uri.parse(url), headers: {'content-type': 'application/json', 'accept': 'application/json'}, body: jsonBody);
    return _handleResponse(response);
  }

  Map? _handleResponse(Response response){
    if(response.statusCode == 200){
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }else if(response.statusCode == 204) {
      return null;
    }else if (response.statusCode ==400){
      throw HttpError.badRequest;
    }else{
      throw HttpError.serverError;
    }
  }
  
}