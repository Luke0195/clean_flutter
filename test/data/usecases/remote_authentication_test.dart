import 'package:flutter_tdd/data/http/http_error.dart';
import 'package:flutter_tdd/domain/helpers/domain_error.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_authentication_test.mocks.dart';

import 'package:faker/faker.dart';
import 'package:flutter_tdd/data/http/http_client.dart';
import 'package:flutter_tdd/domain/usecases/authentication.dart';
import 'package:flutter_tdd/data/usecases/remote_authentication.dart';


// Dicas de testes
// - Testar o input dos dados
// - Testar os output.
@GenerateMocks([HttpClient])
void main(){
  late MockHttpClient httpClient;
  late RemoteAuthentication sut;
  late AuthenticationParams authenticationParams;
  late String url;

  setUp((){
    authenticationParams = AuthenticationParams(email: faker.internet.email(), 
    secret: faker.internet.password());
    url = faker.internet.httpUrl();
    httpClient = MockHttpClient();
    sut = RemoteAuthentication(url: url, httpClient: httpClient);
  });
  
  test('Should call HttpClient with correct values', ()async{
    await sut.authentication(authenticationParams);
    verify(httpClient.request(url: url, method: 'post', body: { 'email': authenticationParams.email, 'password': authenticationParams.secret}));
  }); 

  test('Should throws UnexpectedError if HttpClient throws', ()async {
    when(httpClient.request(url: anyNamed("url"), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.badRequest);
    final future = sut.authentication(authenticationParams);
    expect(future, throwsA(DomainError.unexpected));
  });
}