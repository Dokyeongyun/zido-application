import 'package:flutter/material.dart';
import 'package:zido/menu_icon_button.dart';

class MenuBoardContainer extends StatelessWidget {
  const MenuBoardContainer({
    super.key,
    required this.title,
    required this.iconImages,
  });

  final String title;
  final List<Image> iconImages;

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
          MenuBoardTitleContainer(
            title: title,
          ),
          MenuBoardMenuListRow(
            iconImages: iconImages,
          ),
        ],
      ),
    );
  }
}

class MenuBoardTitleContainer extends StatelessWidget {
  const MenuBoardTitleContainer({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
      child: Row(children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        )
      ]),
    );
  }
}

class MenuBoardMenuListRow extends StatelessWidget {
  const MenuBoardMenuListRow({
    super.key,
    required this.iconImages,
  });

  final List<Image> iconImages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (Image iconImage in iconImages)
          MenuIconButton(iconImage: iconImage),
      ],
    );
  }
}
