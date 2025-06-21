import 'package:flutter_tdd/data/http/http_error.dart';
import 'package:flutter_tdd/domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel({required this.accessToken});

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(accessToken: json['accessToken']);
  }

  AccountEntity toEntity() {
    return AccountEntity(accessToken);
  }
}
