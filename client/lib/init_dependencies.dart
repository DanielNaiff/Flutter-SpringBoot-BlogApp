import 'package:blog_app_springboot/core/common/cubbits/app_user/app_user_cubit.dart';
import 'package:blog_app_springboot/core/network/http_service.dart';
import 'package:blog_app_springboot/core/secrets/app_secrets.dart';
import 'package:blog_app_springboot/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_springboot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/use_login.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_springboot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_springboot/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app_springboot/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app_springboot/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app_springboot/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app_springboot/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app_springboot/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Cliente HTTP base
  getIt.registerSingleton<HttpClientService>(
    HttpClientService(baseUrl: AppSecrets.springBootUrl),
  );
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  _initAuth();
  _initBlog();

  getIt.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // Data source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<HttpClientService>()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  // Usecase
  getIt.registerLazySingleton<UserSignUp>(
    () => UserSignUp(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerLazySingleton<UserLogin>(
    () => UserLogin(authRepository: getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory<CurrentUser>(
    () => CurrentUser(authRepository: getIt<AuthRepositoryImpl>()),
  );

  // Bloc
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      currentUser: getIt<CurrentUser>(),
      userSignUp: getIt<UserSignUp>(),
      userLogin: getIt<UserLogin>(),
      appUserCubit: getIt<AppUserCubit>(),
    ),
  );
}

void _initBlog() {
  // Datasource
  getIt
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(getIt()),
    )
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(getIt()))
    // Usecases
    ..registerFactory(() => UploadBlog(getIt()))
    ..registerFactory(() => GetAllBlogs(getIt()))
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(uploadBlog: getIt(), getAllBlogs: getIt()),
    );
}
