import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_authentication_test.mocks.dart';

abstract class HttpClient {
  Future<void> request({ required String url, required String method })async {}
}

class RemoteAuthentication{
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({ required this.url, required this.httpClient});
  Future<void> authentication() async{
    await httpClient.request(url: url, method: 'post');
  }
} 

@GenerateMocks([HttpClient])
void main(){
  late MockHttpClient httpClient;
  late RemoteAuthentication sut;
  late String url;
  
  setUp((){
    url = faker.internet.httpUrl();
    httpClient = MockHttpClient();
    sut = RemoteAuthentication(url: url, httpClient: httpClient);
  });
  
  test('Should call HttpClient with correct values', ()async{
    await sut.authentication();
    verify(httpClient.request(url: url, method: 'post'));
  }); 
}