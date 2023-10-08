import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment({
    super.key,
    required this.text,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // comment
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),

          // user, time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              ),
              // const Text(' . '),
              Text(
                time,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}