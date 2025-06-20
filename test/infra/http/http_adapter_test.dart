
import 'dart:convert';


import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

import 'package:flutter_tdd/data/http/http_client.dart';
import 'http_adapter_test.mocks.dart';

class HttpAdapter implements HttpClient {
  final Client httpClient;

  const HttpAdapter({ required this.httpClient});
  
  @override
  Future<Map?> request({ required String url, required String method, Map? body}) async {
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response =  await httpClient.post(Uri.parse(url), headers: {'content-type': 'application/json', 'accept': 'application/json'}, body: jsonBody);
    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
  
}

@GenerateMocks([Client])
void main(){
    late String url;
    late Map<String, String> headers;
    late MockClient mockClient;
    late HttpAdapter sut;

    setUp((){
        url = faker.internet.httpUrl();
        headers = {'content-type': 'application/json', 'accept': 'application/json'};
        mockClient = MockClient();
        sut = HttpAdapter(httpClient: mockClient);
    });
    
  group('post', (){
    PostExpectation mockRequest()=> when(mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')));

    void mockResponse(int statusCode, {String body = '{"any_key": "any_value"}'}){
        mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp((){
      mockResponse(200);
    });
    test('Should call post with correct values', ()async {
      await sut.request(url: url , method: 'post', body: {'any_key': 'any_value'});
      verify(mockClient.post(Uri.parse(url), headers:headers , body: jsonEncode({'any_key': 'any_value'}) ));
    });

    test('Should call post with without  body', ()async {
      await sut.request(url: url , method: 'post');
      verify(mockClient.post(Uri.parse(url), headers:headers));
    });

    test('Should returns data if post returns 200',  ()async {
      final response = await sut.request(url: url, method: 'post');
      expect(response, {'any_key': 'any_value'});
    });

    test('Should return empty map if post returns 200 with no data', ()async {
      mockResponse(200, body: '');
      final response = await sut.request(url: url, method: 'post');
      expect(response, isNull);
    });

    test('Should returns null if post returns 204', () async {
      mockResponse(204,body: '');
      final response = await sut.request(url: url, method: 'post');
      expect(response, isNull);
    });

  });
}