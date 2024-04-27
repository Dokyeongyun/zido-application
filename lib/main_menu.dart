import 'package:flutter/material.dart';
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
    return const KakaoMapContainer();
  }
}
