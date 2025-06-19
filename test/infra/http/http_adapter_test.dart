
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

import 'http_adapter_test.mocks.dart';

class HttpAdapter{
  final Client httpClient;

  const HttpAdapter({ required this.httpClient});
  
  Future<void> request({ required String url, required String method, Map? json}) async {
    await httpClient.post(Uri.parse(url));
  }
  
}

@GenerateMocks([Client])
void main(){
  
  group('post', (){
    test('Should call post with correct values', ()async {
      final url = faker.internet.httpUrl();
      final client = MockClient();
      when(client.post(Uri.parse(url))).thenAnswer((_) async => Response('ok', 200));
      final sut = HttpAdapter(httpClient: client);
      await sut.request(url: url , method: 'post');
      verify(client.post(Uri.parse(url)));
    });
  });
}