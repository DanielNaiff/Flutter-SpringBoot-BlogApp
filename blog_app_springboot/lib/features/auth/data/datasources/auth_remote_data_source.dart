import 'dart:convert';

import 'package:blog_app_springboot/core/error/exceptions.dart';
import 'package:blog_app_springboot/core/secrets/app_secrets.dart';
import 'package:blog_app_springboot/features/auth/data/model/user_model.dart';
import 'package:http/http.dart' as http;

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
  final String _baseUrl = AppSecrets.springBootUrl;

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/users');
      print('Enviando requisição POST para $url');
      print(
        'Body: ${jsonEncode({'username': name, 'email': email, 'password': password})}',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': name,
          'email': email,
          'password': password,
        }),
      );

      print('Status code da resposta: ${response.statusCode}');
      print('Body da resposta: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('JSON decodificado: $data');
        return UserModel.fromJson(data);
      } else if (response.statusCode == 422) {
        print('Erro: E-mail já cadastrado.');
        throw const ServeException('E-mail já cadastrado.');
      } else {
        print('Erro inesperado: ${response.statusCode}');
        throw ServeException('Erro inesperado: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception capturada: $e');
      throw ServeException(e.toString());
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
}
