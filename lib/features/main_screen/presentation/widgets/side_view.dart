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
    if (task == null) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Center(
          child: Text(
            "Click on a task to view details.",
            style: kHintTextStyle.copyWith(
              fontSize: 30,
              color: const Color.fromARGB(55, 158, 158, 158),
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task!.taskName,
              overflow: TextOverflow.ellipsis,
              style: kTaskTextStyle.copyWith(
                  fontSize: 40, fontStyle: FontStyle.italic),
            )
          ],
        ),
      );
    }
  }
}
