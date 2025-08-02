import 'dart:typed_data';
import 'package:blog_app_springboot/core/common/entities/token.dart';
import 'package:blog_app_springboot/core/error/exceptions.dart';
import 'package:blog_app_springboot/features/blog/data/models/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required Uint8List image, // Alterado para Uint8List
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
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response = await client.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        final blogData = jsonDecode(response.body);
        return BlogModel.fromJson(blogData);
      } else {
        throw ServerException(
          'Falha ao fazer upload do blog: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required Uint8List image,
    required BlogModel blog,
  }) async {
    try {
      if (blog.id == null) {
        throw ServerException(
          'Blog ID não está disponível para upload da imagem',
        );
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/images'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: '${blog.id}.jpg',
        ),
      );

      request.fields['blogId'] = blog.id.toString();

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(responseBody);
        return jsonData['imageUrl'] as String; // ou ajuste conforme backend
      } else {
        throw ServerException(
          'Falha ao fazer upload da imagem: ${response.statusCode}',
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
