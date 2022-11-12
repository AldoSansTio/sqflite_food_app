import 'package:flutter/material.dart';

const mainColor = Color(0xFFFFCC00);
const white = Color(0xFFFFFFFF);
final grey400 = Colors.grey[400];

Color getColor(String jenis) {
  if (jenis == "Makanan") {
    return Colors.orange;
  } else if (jenis == "Minuman") {
    return const Color(0xFF00B4D8);
  } else {
    return Colors.red;
  }
}
