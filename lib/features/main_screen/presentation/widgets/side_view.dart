import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/features/todo_list/presentation/widgets/task_widget.dart';

class SideView extends StatelessWidget {
  const SideView({
    super.key,
    this.task,
  });

  final TaskWidget? task;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: task != null,
//shows if no task is selected
      replacement: Center(
        child: Text(
          "Click on a task to view detials.",
          style: kHintTextStyle.copyWith(
              fontSize: 30, color: const Color.fromARGB(55, 158, 158, 158)),
        ),
      ),
//shows if a task is selected
      child: Container(),
    );
  }
}
