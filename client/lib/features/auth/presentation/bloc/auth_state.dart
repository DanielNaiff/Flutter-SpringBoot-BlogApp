import 'package:blog_app_springboot/core/common/entities/user.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}
