import 'package:blog_app_springboot/core/common/entities/user.dart';
import 'package:blog_app_springboot/core/error/failures.dart';
import 'package:blog_app_springboot/core/usecase/usecase.dart';
import 'package:blog_app_springboot/features/blog/domain/entities/blog.dart';
import 'package:blog_app_springboot/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
