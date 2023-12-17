import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    Key? key,
    required this.title,
    required this.color,
    required this.value,
  }) : super(key: key);

  final int value;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.people,
          color: color,
          size: 40,
        ),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value.toStringAsFixed(0),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
