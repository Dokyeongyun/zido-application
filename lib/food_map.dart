import 'package:flutter/material.dart';
import 'package:zido/food.dart';
import 'package:zido/food_item.dart';
import 'package:zido/user.dart';

class FoodMap extends StatelessWidget {
  const FoodMap({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 50,
            title: Text(
              title,
              style: const TextStyle(fontSize: 16.0),
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
      ),
    );
  }
}
