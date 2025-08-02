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
  Future<Either<Failure, Blog>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    BlogModel blogModel = BlogModel(
      id: const Uuid().v1(),
      posterId: posterId,
      title: title,
      content: content,
      imageData: image,
      topics: topics,
      updatedAt: DateTime.now(),
    );

    final imageUrl = await blogRemoteDataSource.uploadBlogImage(
      image: image,
      blog: blogModel,
    );

    blogModel = blogModel.copyWith(imageData: image);

    final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
    return right(uploadedBlog);
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    final blogs = await blogRemoteDataSource.getAllBlogs();
    return right(blogs);
  }
}
