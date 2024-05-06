import 'package:flutter/material.dart';

class User {
  const User({
    required this.nickname,
    required this.image,
  });

  final String nickname;
  final ImageProvider image;
}
