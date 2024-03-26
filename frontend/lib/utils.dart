import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomColor {
  static const purple = Color(0xff9F77E2);
  static const grey = Color(0xFF1E1E1E);
  static const lightgrey = Color(0xFF606060);
}

class Date {
  static DateTime parseDate(String dateString) {
    DateFormat format = DateFormat('MM/dd/yyyy');
    return format.parse(dateString);
  }
}
