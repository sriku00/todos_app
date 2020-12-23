import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 20,
          content: Text(text),
          duration: Duration(seconds: 2),
        ));
}
