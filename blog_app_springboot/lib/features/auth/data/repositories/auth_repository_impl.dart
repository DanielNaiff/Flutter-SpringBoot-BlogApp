import 'package:blog_app_springboot/core/error/failures.dart';
import 'package:blog_app_springboot/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_springboot/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> logInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement logInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) {
    // TODO: implement signUpWithEmailPassword
    throw UnimplementedError();
  }
}
