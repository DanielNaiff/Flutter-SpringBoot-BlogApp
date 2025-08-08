import 'dart:typed_data';
import 'package:blog_app_springboot/core/common/entities/token.dart';
import 'package:blog_app_springboot/core/error/exceptions.dart';
import 'package:blog_app_springboot/features/blog/data/models/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlogWithImage({
    required Uint8List image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'http://localhost:8080/api/blogs';
  final token = TokenStorage.getToken();

  BlogRemoteDataSourceImpl(this.client);

  @override
  Future<BlogModel> uploadBlogWithImage({
    required Uint8List image,
    required BlogModel blog,
  }) async {
    try {
      final token = await TokenStorage.getToken();

      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl));

      // Adiciona o token no header Authorization
      request.headers['Authorization'] = 'Bearer $token';

      // Converte o BlogModel para JSON (sem o campo da imagem) e adiciona no campo 'blog'
      request.fields['blog'] = jsonEncode({
        'userId': blog.posterId,
        'title': blog.title,
        'content': blog.content,
        'topics': blog.topics,
        // NÃO inclua o campo da imagem aqui porque ela vai como arquivo separado
      });

      // Adiciona a imagem como arquivo na chave 'image'
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: '${blog.id ?? 'blog'}.jpg',
        ),
      );

      // Envia a requisição
      final response = await request.send();

      // Pega o corpo da resposta como string
      final responseBody = await response.stream.bytesToString();

      // Verifica se deu certo e decodifica o JSON para BlogModel
      if (response.statusCode == 201) {
        final data = jsonDecode(responseBody);
        return BlogModel.fromJson(data);
      } else {
        throw ServerException(
          'Falha ao enviar blog com imagem: ${response.statusCode} - $responseBody',
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final token = await TokenStorage.getToken();

      print(token);

      if (token is! String) {
        throw Exception(
          'Token deve ser uma String, mas é ${token.runtimeType}',
        );
      }

      final response = await client.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> blogData = jsonDecode(response.body);
        return blogData.map((data) => BlogModel.fromJson(data)).toList();
      } else {
        throw ServerException('Falha ao buscar blogs: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
