import 'package:flutter/material.dart';

class Food {
  const Food({
    required this.name,
    required this.icon,
    required this.imagePath,
  });

  final String name;
  final ImageProvider icon;
  final String imagePath;
}
