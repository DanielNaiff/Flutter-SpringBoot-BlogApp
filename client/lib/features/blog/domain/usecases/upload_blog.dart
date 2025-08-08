import 'dart:typed_data';

import 'package:blog_app_springboot/core/error/failures.dart';
import 'package:blog_app_springboot/core/usecase/usecase.dart';
import 'package:blog_app_springboot/features/blog/data/models/blog_model.dart';
import 'package:blog_app_springboot/features/blog/domain/entities/blog.dart';
import 'package:blog_app_springboot/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlogWithImage(
      image: params.image,
      blog: params.blog,
    );
  }
}

class UploadBlogParams {
  final BlogModel blog;
  final String posterId;
  final String title;
  final String content;
  final Uint8List image;
  final List<String> topics;

  UploadBlogParams({
    required this.blog,
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
