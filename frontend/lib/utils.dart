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

  static String getTimeDifference(DateTime postedTime) {
    Duration difference = DateTime.now().difference(postedTime);
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds.abs()}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes.abs()}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours.abs()}h';
    } else if (difference.inDays < 30) {
      return '${difference.inDays.abs()}d';
    } else {
      return DateFormat.yMMMd().format(postedTime);
    }
  }
  
}
