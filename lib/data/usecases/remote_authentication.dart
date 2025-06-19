import '../../domain/usecases/authentication.dart';

import '../http/http_client.dart';

class RemoteAuthentication{
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({ required this.url, required this.httpClient});

  Future<void> authentication(AuthenticationParams authenticationParams) async{
    final body = RemoteAuthenticationParams.fromDomain(authenticationParams);
    await httpClient.request(url: url, method: 'post', body: body.toJson());
  }
} 


class RemoteAuthenticationParams{
  final String email;
  final String password;

  RemoteAuthenticationParams({ required this.email, required this.password });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams authenticationParams){
    return RemoteAuthenticationParams(email: authenticationParams.email, password: authenticationParams.secret);
  }

  Map toJson() => {'email': email, 'password': password};
}