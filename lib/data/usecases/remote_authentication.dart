import 'package:flutter_tdd/domain/usecases/authentication.dart';

import '../http/http_client.dart';

class RemoteAuthentication{
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({ required this.url, required this.httpClient});
  Future<void> authentication(AuthenticationParams authenticationParams) async{
    await httpClient.request(url: url, method: 'post',body: authenticationParams.toJson() );
  }
} 