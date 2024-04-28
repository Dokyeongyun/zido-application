import 'package:flutter/material.dart';
import 'package:zido/menu_icon_button.dart';
import 'package:collection/collection.dart';

class MenuBoardContainer extends StatelessWidget {
  const MenuBoardContainer({
    super.key,
    required this.title,
    required this.menuIconButtons,
  });

  final String title;
  final List<MenuIconButton> menuIconButtons;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(MenuBoardTitleContainer(title: title));
    children.addAll(
      menuIconButtons
          .slices(5)
          .map((e) => MenuBoardMenuListRow(
                menuIconButtons: e,
              ))
          .toList(),
    );

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
      child: Column(children: children),
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
          style: const TextStyle(fontSize: 15.0),
        )
      ]),
    );
  }
}

class MenuBoardMenuListRow extends StatelessWidget {
  const MenuBoardMenuListRow({
    super.key,
    required this.menuIconButtons,
  });

  final List<MenuIconButton> menuIconButtons;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: menuIconButtons,
    );
  }
}
