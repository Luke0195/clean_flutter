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
  late String accessToken;

  setUp((){
    accessToken = faker.guid.guid();
    authenticationParams = AuthenticationParams(email: faker.internet.email(), 
    secret: faker.internet.password());
    url = faker.internet.httpUrl();
    httpClient = MockHttpClient();
    sut = RemoteAuthentication(url: url, httpClient: httpClient);
  });
  
  test('Should call HttpClient with correct values', ()async{
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed("body"))).thenAnswer((_)async => {'accessToken': accessToken});
    await sut.auth(authenticationParams);
    verify(httpClient.request(url: url, method: 'post', body: { 'email': authenticationParams.email, 'password': authenticationParams.secret}));
  }); 

  test('Should throws UnexpectedError if HttpClient throws 400', ()async {
    when(httpClient.request(url: anyNamed("url"), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.badRequest);
    final future = sut.auth(authenticationParams);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throws InvalidCredencials if HttpClient throws 401', ()async {
    when(httpClient.request(url: anyNamed("url"), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.unauthorized);
    final future = sut.auth(authenticationParams);
    expect(future, throwsA(DomainError.invalidCredencials));
  });
  test('Should throws UnexpectedError if HttpClient throws 404', ()async {
    when(httpClient.request(url: anyNamed("url"), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.notFound);
    final future = sut.auth(authenticationParams);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throws UnexpectedError if HttpClient throws 500', ()async {
    when(httpClient.request(url: anyNamed("url"), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.serverError);
    final future = sut.auth(authenticationParams);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should returns an AccountEntity if HttpClient returns 200', ()async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed("body"))).thenAnswer((_)async => {'accessToken': accessToken});
    final result = await sut.auth(authenticationParams);
    expect(result.token, equals(accessToken));
  });

  test('Should returns 200 with invalid data', () async{
    when(httpClient.request(url: anyNamed('url'), method: anyNamed("method"), body: anyNamed("body"))).thenAnswer((_)async => {'invalid_token': 'invalid_token'});
  });
}