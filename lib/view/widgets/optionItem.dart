import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  final String title;
  const OptionItem({super.key, this.onTap, required this.icon, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          spacing: 20,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
