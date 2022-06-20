import 'package:flutter/material.dart';
import '../../../widgets/home_view_widgets/task_button.dart';
import '../../patient_list_view.dart';

class SecondRowTaskButtons extends StatelessWidget {
  const SecondRowTaskButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TaskButton(
            taskType: TaskType.viewAll,
            onTap: () {
              Navigator.of(context).pushNamed(PatientListView.routeName);
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TaskButton(
            taskType: TaskType.delete,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
