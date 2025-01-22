import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  void Function()? onPressed;
  String title;
  MyButton({super.key, this.onPressed, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 20, horizontal: 20))),
          onPressed: onPressed,
          child: Text(title)),
    );
  }
}
