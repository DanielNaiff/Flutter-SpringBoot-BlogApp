import 'package:bloc/bloc.dart';
import 'package:blog_app_springboot/core/common/cubbits/app_user/app_user_cubit.dart';
import 'package:blog_app_springboot/core/common/entities/user.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/use_login.dart';
import 'package:blog_app_springboot/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_springboot/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app_springboot/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    // emit(AuthLoading());
    final response = await _currentUser(NoParams());

    response.fold((failure) => emit(AuthFailure(failure.message.toString())), (
      user,
    ) {
      print("##########" + user.id);
      _emitAuthSuccess(user, emit);
    });
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final response = await _userLogin(
      UserLoginParams(
        email: event.email.toString(),
        password: event.password.toString(),
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message.toString())),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
