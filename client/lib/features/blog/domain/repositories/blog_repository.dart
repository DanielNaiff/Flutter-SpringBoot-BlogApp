import 'dart:typed_data';

import 'package:blog_app_springboot/core/error/failures.dart';
import 'package:blog_app_springboot/features/blog/data/models/blog_model.dart';
import 'package:blog_app_springboot/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlogWithImage({
    required Uint8List image,
    required BlogModel blog,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
