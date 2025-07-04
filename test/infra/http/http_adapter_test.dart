import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_tdd/data/http/http_error.dart';
import 'package:flutter_tdd/infra/http/http_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

import 'http_adapter_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late String url;
  late Map<String, String> headers;
  late MockClient mockClient;
  late HttpAdapter sut;

  setUp(() {
    url = faker.internet.httpUrl();
    headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    mockClient = MockClient();
    sut = HttpAdapter(httpClient: mockClient);
  });

  group('shared', () {
    test('Should throws ServerError if invalid method is provided', () async {
      final future = sut.request(
        url: url,
        method: 'invalid_method',
        body: {'any_key': 'any_value'},
      );
      expect(future, throwsA(HttpError.serverError));
    });
  });
  group('post', () {
    PostExpectation mockRequest() => when(
      mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    );

    void mockResponse(
      int statusCode, {
      String body = '{"any_key": "any_value"}',
    }) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      mockRequest().thenThrow(Exception());
    }

    setUp(() {
      mockResponse(200);
    });
    test('Should call post with correct values', () async {
      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
      );
      verify(
        mockClient.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode({'any_key': 'any_value'}),
        ),
      );
    });

    test('Should call post with without  body', () async {
      await sut.request(url: url, method: 'post');
      verify(mockClient.post(Uri.parse(url), headers: headers));
    });

    test('Should returns data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');
      expect(response, {'any_key': 'any_value'});
    });

    test('Should return empty map if post returns 200 with no data', () async {
      mockResponse(200, body: '');
      final response = await sut.request(url: url, method: 'post');
      expect(response, isNull);
    });

    test('Should returns null if post returns 204', () async {
      mockResponse(204, body: '');
      final response = await sut.request(url: url, method: 'post');
      expect(response, isNull);
    });

    test('Should returns null if post returns 204 with data', () async {
      mockResponse(204);
      final response = await sut.request(url: url, method: 'post');
      expect(response, isNull);
    });

    test('Should returns BadRequestError if post returns 400', () async {
      mockResponse(400, body: '{"message": "error"}');
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.badRequest));
    });

    test(
      'Should returns BadRequestError if post returns 400 if no body',
      () async {
        mockResponse(400, body: '');
        final future = sut.request(url: url, method: 'post');
        expect(future, throwsA(HttpError.badRequest));
      },
    );

    test('Should returns BadRequestError if post returns 400', () async {
      mockResponse(400, body: '');
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should returns BadRequestError if post returns 401', () async {
      mockResponse(401, body: '');
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should returns BadRequestError if post returns 403', () async {
      mockResponse(403, body: '');
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should returns BadRequestError if post returns 404', () async {
      mockResponse(403, body: '');
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should returns ServerError if post returns 500', () async {
      mockResponse(500);
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.serverError));
    });

    test('Should returns ServerError if post throws', () async {
      mockError();
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.serverError));
    });
  });
}
