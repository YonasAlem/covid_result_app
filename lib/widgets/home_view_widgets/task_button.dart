import 'package:flutter/material.dart';

enum TaskType { register, update, viewAll, delete }

class TaskButton extends StatelessWidget {
  TaskButton({Key? key, this.onTap, required this.taskType}) : super(key: key);

  final Function()? onTap;

  final TaskType taskType;

  final Map<TaskType, Map<String, Object>> values = {
    TaskType.register: {
      "icon": Icons.post_add,
      "title": "Register",
      "description": "Create new patient record.",
      "color": const Color(0xFF628ec5),
    },
    TaskType.update: {
      "icon": Icons.update_rounded,
      "title": "Update",
      "description": "Alter an existing record.",
      "color": const Color(0xffb774bd),
    },
    TaskType.viewAll: {
      "icon": Icons.view_list_rounded,
      "title": "View All",
      "description": "Display all records from database.",
      "color": const Color(0xFFdb7634),
    },
    TaskType.delete: {
      "icon": Icons.delete_outline,
      "title": "Delete",
      "description": "Remove an existing record from database.",
      "color": const Color(0xff8866cf),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: values[taskType]!["color"] as Color,
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
                values[taskType]!["icon"] as IconData,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(height: 10),
              Text(
                values[taskType]!["title"] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontFamily: 'Bold',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                values[taskType]!["description"] as String,
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
