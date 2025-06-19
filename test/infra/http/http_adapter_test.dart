
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

import 'http_adapter_test.mocks.dart';

class HttpAdapter{
  final Client httpClient;

  const HttpAdapter({ required this.httpClient});
  
  Future<void> request({ required String url, required String method, Map? body}) async {
    final jsonBody = body != null ? jsonEncode(body) : null;
    await httpClient.post(Uri.parse(url), headers: {'content-type': 'application/json', 'accept': 'application/json'}, body: jsonBody);
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
    test('Should call post with correct values', ()async {
      when(mockClient.post(Uri.parse(url), headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => Response('ok', 200));
      await sut.request(url: url , method: 'post', body: {'any_key': 'any_value'});
      verify(mockClient.post(Uri.parse(url), headers:headers , body: jsonEncode({'any_key': 'any_value'}) ));
    });


    test('Should call post with without  body', ()async {
      when(mockClient.post(Uri.parse(url), headers: anyNamed('headers'))).thenAnswer((_) async => Response('ok', 200));
      await sut.request(url: url , method: 'post');
      verify(mockClient.post(Uri.parse(url), headers:headers));
    });
    
  });
}