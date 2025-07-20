import 'dart:convert';

import 'package:blog_app_springboot/core/network/http_service.dart';
import 'package:blog_app_springboot/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClientService client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      '/users',
      body: {'username': name, 'email': email, 'password': password},
    );

    final data = jsonDecode(response.body);
    return UserModel.fromJson(data);
  }

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }
}

@override
Future<String> loginWithEmailPassword({
  required String email,
  required String password,
}) {
  // Implementar depois
  throw UnimplementedError();
}
