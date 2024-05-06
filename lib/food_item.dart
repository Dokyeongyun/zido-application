import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zido/food.dart';
import 'package:zido/user.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    super.key,
    required this.user,
    required this.writer,
    required this.food,
    required this.content,
    required this.createdDate,
  });

  final User user;
  final User writer;
  final Food food;
  final String content;
  final DateTime createdDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12.5,
                  backgroundImage: writer.image,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 5),
                Text(
                  writer.nickname,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            food.imagePath,
            fit: BoxFit.contain,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: food.icon,
                  backgroundColor: const Color.fromARGB(255, 231, 231, 231),
                ),
                const SizedBox(width: 10),
                Text(
                  food.name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${writer.nickname} ',
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: content,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                      style: DefaultTextStyle.of(context).style,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12.5,
                  backgroundImage: user.image,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 5),
                const Text(
                  '댓글 추가...',
                  style: TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                Text(
                  formatDateTime(createdDate),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97),
                    fontSize: 10.5,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('M월 d일');
    return formatter.format(dateTime);
  }
}
