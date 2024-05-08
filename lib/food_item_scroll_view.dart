import 'package:flutter/material.dart';
import 'package:zido/food.dart';
import 'package:zido/food_item.dart';
import 'package:zido/user.dart';

class FoodItemScrollView extends StatelessWidget {
  const FoodItemScrollView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 50,
          titleSpacing: 0.0,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          snap: false,
          floating: true,
          pinned: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              FoodItem(
                user: const User(
                  nickname: 'Man',
                  image: AssetImage("assets/images/man.png"),
                ),
                writer: const User(
                  nickname: 'Woman',
                  image: AssetImage("assets/images/woman.png"),
                ),
                content: 'Very delicious food!',
                food: const Food(
                  name: '닭날개+참치밥+계란찜',
                  icon: AssetImage("assets/images/roast-chicken.png"),
                  imagePath: 'assets/images/our-food-1.jpeg',
                ),
                createdDate: DateTime.now(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
