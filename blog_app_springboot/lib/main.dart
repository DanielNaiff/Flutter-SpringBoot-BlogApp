import 'package:blog_app_springboot/core/theme/theme.dart';
import 'package:blog_app_springboot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_springboot/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app_springboot/init_dependencies.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(
    DevicePreview(
      enabled: true,
      builder:
          (context) => MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
            ],
            child: const MyApp(),
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
