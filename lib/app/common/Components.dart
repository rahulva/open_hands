import 'package:flutter/material.dart';

class Components{
  static AppBar buildAppBar(String text) {
    return AppBar(
      backgroundColor: Colors.indigo[700],
      elevation: 0.0,
      title: Text(text),
    );
  }
}