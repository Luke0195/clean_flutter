import '../entities/entities.dart';

abstract interface class Authentication{
  Future<AccountEntity> auth({ required String email, required String password });
}