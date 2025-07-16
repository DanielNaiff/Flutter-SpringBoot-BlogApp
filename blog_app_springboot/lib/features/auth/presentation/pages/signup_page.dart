import 'package:blog_app_springboot/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Sign Up.",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          AuthField(hintText: 'Email'),
        ],
      ),
    );
  }
}
