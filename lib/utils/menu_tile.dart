import 'package:flutter/material.dart';

class MyMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const MyMenuTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
