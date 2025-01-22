import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  NavIcon({super.key, required this.onPressed, this.title = '', required this.icon});

  void Function()? onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(
              title,
              style: TextStyle(fontSize: 10),
            )
          ],
        ));
  }
}
