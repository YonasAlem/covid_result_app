import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  const TaskButton(
      {Key? key, this.color, this.icon, required this.title, required this.desc, this.onTap})
      : super(key: key);

  final Color? color;
  final IconData? icon;
  final String title;
  final String desc;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(15),
      shadowColor: Colors.black,
      elevation: 10,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontFamily: 'Bold',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                desc,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  letterSpacing: 1,
                  fontFamily: 'Bold',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
