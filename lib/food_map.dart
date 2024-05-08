import 'package:flutter/material.dart';
import 'package:zido/kakao_map_container.dart';
import 'package:zido/square_icon_button.dart';

class FoodMap extends StatelessWidget {
  const FoodMap({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        KakaoMapContainer(height: double.infinity),
        TopButtonBar(),
        FoodMapDraggableScrollableSheet(),
      ],
    ));
  }
}

class FoodMapDraggableScrollableSheet extends StatelessWidget {
  const FoodMapDraggableScrollableSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.1,
      maxChildSize: 0.895,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            height: 1000,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.35),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 198, 198, 198),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      height: 4,
                      width: 32,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SliverList.list(
                  children: const [],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TopButtonBar extends StatelessWidget {
  const TopButtonBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(12, 28, 12, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SquareIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 0.4,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xffA1CE5D),
                      ),
                      Text(
                        '서초구 양재동',
                        style: TextStyle(
                          color: Color.fromARGB(255, 105, 105, 105),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SquareIconButton(
            onPressed: null,
            icon: Icon(
              Icons.map_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
