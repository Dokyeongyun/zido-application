import 'package:flutter/material.dart';

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({
    super.key,
    required this.iconImage,
    required this.name,
    this.menuHomeScreen,
    this.boxSize = 50,
  });

  final Image iconImage;
  final String name;
  final double boxSize;
  final Widget? menuHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
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
                  onTap: () {
                    if (menuHomeScreen != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => menuHomeScreen!,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              name,
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
