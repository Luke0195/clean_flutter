import 'package:flutter_tdd/data/http/http_error.dart';
import 'package:flutter_tdd/domain/entities/entities.dart';
import 'package:flutter_tdd/domain/helpers/domain_error.dart';

import '../../domain/usecases/authentication.dart';

import '../http/http_client.dart';

class RemoteAuthentication{
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({ required this.url, required this.httpClient});

  Future<AccountEntity> auth(AuthenticationParams authenticationParams) async{
    final body = RemoteAuthenticationParams.fromDomain(authenticationParams);
    try{
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body.toJson());
      return AccountEntity.fromJson(httpResponse);
    }on HttpError catch(error){
    throw error == HttpError.unauthorized ? DomainError.invalidCredencials : DomainError.unexpected;
    }
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