import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init_dependencies() async {
  _initAuth();
}

void _initAuth() {}
