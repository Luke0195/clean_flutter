import 'package:faker/faker.dart';
import 'package:flutter_tdd/domain/usecases/authentication.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_authentication_test.mocks.dart';

abstract class HttpClient {
  Future<void> request({ required String url, required String method, Map? body  })async {}
}

class RemoteAuthentication{
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({ required this.url, required this.httpClient});
  Future<void> authentication(AuthenticationParams authenticationParams) async{
    await httpClient.request(url: url, method: 'post',body: authenticationParams.toJson() );
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
    
    final authenticationParams = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    await sut.authentication(authenticationParams);
    verify(httpClient.request(url: url, method: 'post', body: { 'email': authenticationParams.email, 'password': authenticationParams.secret}));
  }); 
}