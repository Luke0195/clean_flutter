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
void main() {
  late MockHttpClient httpClient;
  late RemoteAuthentication sut;
  late AuthenticationParams authenticationParams;
  late String url = faker.internet.httpUrl();
  late String accessToken = faker.guid.guid();

  PostExpectation mockRequest() => when(
    httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed("body"),
    ),
  );

  Map validData() => {'accessToken': accessToken};

  void mockHttpData(Map json) async =>
      mockRequest().thenAnswer((_) async => json);

  void mockError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    authenticationParams = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );
    httpClient = MockHttpClient();
    sut = RemoteAuthentication(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {
    mockHttpData(validData());
    await sut.auth(authenticationParams);
    verify(
      httpClient.request(
        url: url,
        method: 'post',
        body: {
          'email': authenticationParams.email,
          'password': authenticationParams.secret,
        },
      ),
    );
  });

  test('Should throws UnexpectedError if HttpClient throws 400', () async {
    mockError(HttpError.badRequest);
    final future = sut.auth(authenticationParams);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throws InvalidCredencials if HttpClient throws 401', () async {
    mockError(HttpError.unauthorized);
    final future = sut.auth(authenticationParams);
    expect(future, throwsA(DomainError.invalidCredencials));
  });
  test('Should throws UnexpectedError if HttpClient throws 404', () async {
    mockError(HttpError.notFound);
    final future = sut.auth(authenticationParams);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throws UnexpectedError if HttpClient throws 500', () async {
    mockError(HttpError.serverError);
    final future = sut.auth(authenticationParams);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should returns an AccountEntity if HttpClient returns 200', () async {
    mockHttpData(validData());
    final result = await sut.auth(authenticationParams);
    expect(result.token, equals(accessToken));
  });

  test(
    'Should returns UnexpectedError if HttpClient returns 200 with invalid data',
    () async {
      mockHttpData({'invalid_token': 'invalid_token'});
      final future = sut.auth(authenticationParams);
      expect(future, throwsA(DomainError.unexpected));
    },
  );
}
