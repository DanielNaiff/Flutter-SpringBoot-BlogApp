import 'dart:typed_data';

import 'package:blog_app_springboot/core/error/failures.dart';
import 'package:blog_app_springboot/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app_springboot/features/blog/data/models/blog_model.dart';
import 'package:blog_app_springboot/features/blog/domain/entities/blog.dart';
import 'package:blog_app_springboot/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    final blogs = await blogRemoteDataSource.getAllBlogs();
    return right(blogs);
  }

  @override
  Future<Either<Failure, Blog>> uploadBlogWithImage({
    required Uint8List image,
    required BlogModel blog,
  }) async {
    try {
      final uploadedBlog = await blogRemoteDataSource.uploadBlogWithImage(
        image: image,
        blog: blog,
      );
      return right(uploadedBlog);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
