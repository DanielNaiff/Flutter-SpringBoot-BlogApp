import 'dart:typed_data';
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
  static const String _baseUrl =
      'http://your-spring-boot-backend-url:8080/api/blogs';

  BlogRemoteDataSourceImpl(this.client);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response = await client.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(blog.toJson()),
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
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: '${blog.id}.jpg', // Nome do arquivo para referência
        ),
      );
      request.fields['blogId'] = blog.id.toString();

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseData);
        return jsonData['imageUrl']
            as String; // Ajustar se o backend não retornar imageUrl
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
      final response = await client.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
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
