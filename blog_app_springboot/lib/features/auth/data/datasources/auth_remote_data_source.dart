import 'dart:convert';

import 'package:blog_app_springboot/core/network/http_service.dart';
import 'package:blog_app_springboot/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> currentUser();
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
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      '/login',
      body: {'email': email, 'password': password},
    );

    final data = jsonDecode(response.body);
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel?> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }
}
