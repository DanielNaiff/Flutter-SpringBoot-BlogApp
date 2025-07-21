import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color backgroundColor = Colors.black87,
  IconData icon = Icons.info_outline,
  Duration duration = const Duration(seconds: 3),
  String? actionLabel,
  VoidCallback? onAction,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        action:
            (actionLabel != null && onAction != null)
                ? SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction,
                  textColor: Colors.amberAccent,
                )
                : null,
      ),
    );
}
