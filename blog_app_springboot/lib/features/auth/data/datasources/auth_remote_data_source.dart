import 'dart:convert';

import 'package:blog_app_springboot/core/common/entities/token.dart';
import 'package:blog_app_springboot/core/error/exceptions.dart';
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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['accessToken'] as String;

      // Salva token localmente
      await TokenStorage.saveToken(token);

      // Retorna usuário
      return UserModel.fromJson(data);
    } else {
      print("oooooooooooh");
      throw ServerException('Erro ao logar: ${response.statusCode}');
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    final token = await TokenStorage.getToken();
    try {
      final response = await client.get(
        '/me',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else if (response.statusCode == 401) {
        return null;
      } else {
        throw ServerException(
          'Erro inesperado: ${response.statusCode.toString()}',
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
