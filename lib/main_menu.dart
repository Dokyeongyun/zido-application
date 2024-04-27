import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zido/kakao_map_container.dart';
import 'package:zido/menu_board_conatiner.dart';

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
      child: const Column(
        children: [
          KakaoMapContainer(),
          SizedBox(height: 15),
          MenuBoardContainer(),
        ],
      ),
    );
  }
}
