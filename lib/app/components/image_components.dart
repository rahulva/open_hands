import 'package:flutter/cupertino.dart';

AspectRatio itemImage(String? imagePath) {
  return AspectRatio(
    aspectRatio: 2,
    child: Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    ),
  );
}
