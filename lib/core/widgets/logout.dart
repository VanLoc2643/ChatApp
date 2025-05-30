import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}