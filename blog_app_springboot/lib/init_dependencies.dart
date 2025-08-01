import 'package:blog_app_springboot/core/common/cubbits/app_user/app_user_cubit.dart';
import 'package:blog_app_springboot/core/network/http_service.dart';
import 'package:blog_app_springboot/core/secrets/app_secrets.dart';
import 'package:blog_app_springboot/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_springboot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/use_login.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_springboot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Cliente HTTP base
  getIt.registerSingleton<HttpClientService>(
    HttpClientService(baseUrl: AppSecrets.springBootUrl),
  );

  //core
  getIt.registerLazySingleton(() => AppUserCubit());

  _initAuth();
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
