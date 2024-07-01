import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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

class FoodMapDraggableScrollableSheet extends StatefulWidget {
  const FoodMapDraggableScrollableSheet({
    super.key,
  });

  @override
  State<FoodMapDraggableScrollableSheet> createState() =>
      _FoodMapDraggableScrollableSheetState();
}

class _FoodMapDraggableScrollableSheetState
    extends State<FoodMapDraggableScrollableSheet> {
  double initialChildSize = 0.35;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (context, placeProvider, child) {
        if (placeProvider.places.isNotEmpty) {
          initialChildSize = 0.18;
        }

        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
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
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (placeProvider.places.isEmpty) {
                            return const Text('empty.');
                          }

                          final place = placeProvider.places[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 12.0,
                            ),
                            child: Column(
                              children: [
                                PlaceListItem(
                                  category: place.category,
                                  name: place.name,
                                  phone: place.phone,
                                  address: place.address,
                                  url: place.url,
                                ),
                                const SizedBox(height: 10.0),
                                const Divider(
                                  height: 0.0,
                                  thickness: 0.5,
                                )
                              ],
                            ),
                          );
                        },
                        childCount: placeProvider.places.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PlaceListItem extends StatelessWidget {
  const PlaceListItem({
    super.key,
    required this.category,
    required this.name,
    required this.phone,
    required this.address,
    required this.url,
  });

  final String category;
  final String name;
  final String phone;
  final String address;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              category,
              style: const TextStyle(
                color: Color.fromARGB(255, 109, 109, 109),
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        IconText(
          iconData: Icons.phone,
          text: phone,
        ),
        const SizedBox(height: 6),
        IconText(
          iconData: Icons.location_on_outlined,
          text: address,
        ),
        const SizedBox(height: 6),
        IconHiperText(
          iconData: Icons.link,
          text: url,
          url: url,
        ),
      ],
    );
  }
}

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.iconData,
    required this.text,
  });

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return IconItem(
      iconData: iconData,
      item: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(255, 63, 63, 63),
          fontSize: 12.0,
        ),
      ),
    );
  }
}

class IconHiperText extends StatelessWidget {
  const IconHiperText({
    super.key,
    required this.iconData,
    required this.text,
    required this.url,
  });

  final IconData iconData;
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return IconItem(
      iconData: iconData,
      item: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 12,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launchUrl(Uri.parse(url));
            },
        ),
      ),
    );
  }
}

class IconItem extends StatelessWidget {
  const IconItem({
    super.key,
    required this.iconData,
    required this.item,
  });

  final IconData iconData;
  final Widget item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: const Color(0xffA1CE5D),
          size: 16.0,
        ),
        const SizedBox(width: 4),
        item
      ],
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
