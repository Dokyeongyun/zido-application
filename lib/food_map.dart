import 'package:flutter/material.dart';

class FoodMap extends StatelessWidget {
  const FoodMap({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Text(
            title,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
