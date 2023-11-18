import 'package:flutter/material.dart';

class UsefulFunctions {
  static String ellipsify(String str) {
    if (str.length < 35) {
      return str;
    } else {
      return "${str.substring(0, 35)}...";
    }
  }
}
