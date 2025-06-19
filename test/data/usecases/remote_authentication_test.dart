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
  
  test('Should call HttpClient with correct values', ()async{
    final url = faker.internet.httpUrl();
    final httpClient = MockHttpClient();
    final sut = RemoteAuthentication(url: url, httpClient: httpClient);
    await sut.authentication();
    verify(httpClient.request(url: url, method: 'post'));
  }); 
}