import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blog_app_springboot/core/error/exceptions.dart';

class HttpClientService {
  final String baseUrl;

  HttpClientService({required this.baseUrl});

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.get(uri, headers: headers);
      _handleError(response);
      return response;
    } catch (e) {
      print('Erro na requisição POST: $e');
      throw ServeException('Erro na requisição GET: $e');
    }
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final defaultHeaders = {'Content-Type': 'application/json', ...?headers};

    try {
      final response = await http.post(
        uri,
        headers: defaultHeaders,
        body: jsonEncode(body),
      );
      _handleError(response);
      return response;
    } catch (e) {
      print('Erro na requisição POST: $e');
      throw ServeException('Erro na requisição POST: $e');
    }
  }

  void _handleError(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
        // Sucesso, não faz nada
        return;

      case 400:
        throw ServeException('Requisição inválida (400): ${response.body}');
      case 401:
        throw ServeException('Não autorizado (401): acesso negado.');
      case 403:
        throw ServeException('Proibido (403): você não tem permissão.');
      case 404:
        throw ServeException('Recurso não encontrado (404).');
      case 422:
        throw ServeException(
          'Entidade não processável (422): ${response.body}',
        );
      case 500:
        throw ServeException(
          'Erro interno do servidor (500). Tente novamente mais tarde.',
        );
      default:
        if (response.statusCode >= 400 && response.statusCode < 500) {
          throw ServeException(
            'Erro cliente ${response.statusCode}: ${response.body}',
          );
        } else if (response.statusCode >= 500) {
          throw ServeException('Erro servidor ${response.statusCode}.');
        } else {
          // Outros status inesperados
          throw ServeException(
            'Erro inesperado ${response.statusCode}: ${response.body}',
          );
        }
    }
  }
}
