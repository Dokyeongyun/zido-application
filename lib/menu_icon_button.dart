import 'package:flutter/material.dart';

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
