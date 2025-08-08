import 'package:blog_app_springboot/core/common/entities/user.dart';

class UserModel extends User {
  final String accessToken;
  final String expiresIn;
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required this.accessToken,
    required this.expiresIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toString() ?? '',
      email: map['email'] ?? '',
      name: map['username'] ?? '',
      accessToken: map['accessToken'] ?? '',
      expiresIn: map['expiresIn']?.toString() ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? accessToken,
    String? expiresIn,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}
