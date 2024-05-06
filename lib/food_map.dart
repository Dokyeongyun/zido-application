import 'package:flutter/material.dart';
import 'package:zido/food_item_scroll_view.dart';

class FoodMap extends StatelessWidget {
  const FoodMap({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodItemScrollView(title: title),
    );
  }
}
