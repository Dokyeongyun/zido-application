import 'package:flutter/material.dart';
import 'package:zido/main_menu.dart';
import 'package:zido/menu_icon_button.dart';

class MenuBoardContainer extends StatelessWidget {
  const MenuBoardContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
