import 'package:flutter/material.dart';

Future<dynamic> myBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    barrierColor: Colors.white10,
    elevation: 0,
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) {
      return Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10), width: double.infinity, child: child);
    },
  );
}
