import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zido/kakao_map_container.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    super.key,
  });

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const KakaoMapContainer(),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 1.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                  child: const Row(children: [
                    Text(
                      'Draw your Zido',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuIconButton(
                      iconImage: Image.asset('assets/images/rice.png'),
                    ),
                    MenuIconButton(
                      iconImage: Image.asset('assets/images/frying-pan.png'),
                    ),
                    MenuIconButton(
                      iconImage: Image.asset('assets/images/movie.png'),
                    ),
                    MenuIconButton(
                      iconImage: Image.asset('assets/images/earth.png'),
                    ),
                    MenuIconButton(
                      iconImage: Image.asset('assets/images/calendar2.png'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({
    super.key,
    required this.iconImage,
    this.boxSize = 52,
    this.iconWidth = 40,
    this.iconHeight = 40,
  });

  final Image iconImage;
  final double boxSize;
  final double iconWidth;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 243, 243, 243),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: iconWidth,
          height: iconHeight,
          child: InkWell(
            child: iconImage,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
