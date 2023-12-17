import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    required this.icon,
    required this.text,
    required this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
