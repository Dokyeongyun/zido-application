import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zido/kakao_map_container.dart';
import 'package:zido/menu_board_conatiner.dart';
import 'package:zido/menu_icon_button.dart';

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
          MenuBoardContainer(
            title: "Draw your Zido",
            menuIconButtons: [
              MenuIconButton(
                iconImage: Image.asset('assets/images/rice.png'),
                name: '대동맛지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/frying-pan.png'),
                name: '요리할지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/movie.png'),
                name: '재밌을지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/earth.png'),
                name: '여행갈지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/calendar2.png'),
                name: '계획할지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/shopping-cart.png'),
                name: '사버릴지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/selfie.png'),
                name: '추억일지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/gamepad.png'),
                name: '게임할지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/trophy.png'),
                name: '도전할지도',
              ),
              MenuIconButton(
                iconImage: Image.asset('assets/images/sticky-note.png'),
                name: '메모할지도',
              )
            ],
          ),
        ],
      ),
    );
  }
}
