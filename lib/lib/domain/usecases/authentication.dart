import 'package:flutter_tdd/lib/domain/entities/account_entity.dart';

abstract interface class Authentication{
  Future<AccountEntity> auth({ required String email, String password });
}