import 'package:flutter/material.dart';

import '../../../widgets/home_view_widgets/task_button.dart';
import '../../patient_register_view.dart';

class FirstRowTaskButtons extends StatelessWidget {
  const FirstRowTaskButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TaskButton(
            taskType: TaskType.register,
            onTap: () {
              Navigator.of(context).pushNamed(PatientRegisterView.routeName);
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TaskButton(
            taskType: TaskType.update,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
