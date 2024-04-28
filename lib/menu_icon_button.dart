import 'package:flutter/material.dart';

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({
    super.key,
    required this.iconImage,
    required this.name,
    this.boxSize = 50,
  });

  final Image iconImage;
  final String name;
  final double boxSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 243, 243, 243),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              child: InkWell(
                child: iconImage,
                onTap: () {},
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 11,
          ),
        )
      ],
    );
  }
}
