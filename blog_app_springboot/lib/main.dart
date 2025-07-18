import 'package:blog_app_springboot/core/theme/theme.dart';
import 'package:blog_app_springboot/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_springboot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_springboot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_springboot/features/auth/presentation/pages/login_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(
    DevicePreview(
      enabled: true,
      builder:
          (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (_) => AuthBloc(
                      userSignUp: UserSignUp(
                        AuthRepositoryImpl(AuthRemoteDataSourceImpl()),
                      ),
                    ),
              ),
            ],
            child: const MyApp(),
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
