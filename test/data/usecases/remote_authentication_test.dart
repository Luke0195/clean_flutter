import 'package:faker/faker.dart';
import 'package:flutter_tdd/data/http/http_client.dart';
import 'package:flutter_tdd/data/usecases/remote_authentication.dart';
import 'package:flutter_tdd/domain/usecases/authentication.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_authentication_test.mocks.dart';



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