import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';


SnackBar messengerBar(BuildContext context, {required String msg}) {
    return SnackBar(
                         
      content: Text(msg,
      style: TextStyle(
        color: Color.fromARGB(255, 39, 93, 41),
        ),
      ),
      duration: const Duration(milliseconds: 3000),
      width: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 15 // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bg_color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
