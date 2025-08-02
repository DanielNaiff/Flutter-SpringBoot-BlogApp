import 'package:blog_app_springboot/core/common/entities/user.dart';
import 'package:blog_app_springboot/core/error/failures.dart';
import 'package:blog_app_springboot/core/usecase/usecase.dart';
import 'package:blog_app_springboot/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
