import 'package:blog_app_springboot/core/common/cubbits/app_user/app_user_cubit.dart';
import 'package:blog_app_springboot/core/theme/theme.dart';
import 'package:blog_app_springboot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_springboot/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app_springboot/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app_springboot/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app_springboot/features/blog/presentation/pages/blog_page.dart';
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
              BlocProvider<AppUserCubit>(create: (_) => getIt<AppUserCubit>()),
              BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
              BlocProvider<BlogBloc>(create: (_) => getIt<BlogBloc>()),
            ],
            child: const MyApp(),
          ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggeIn) {
          if (isLoggeIn) {
            return BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
