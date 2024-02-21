import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/features/todo_list/presentation/widgets/task_widget.dart';
import 'package:intl/intl.dart';

class SideView extends StatelessWidget {
  const SideView({
    super.key,
    this.task,
  });

  final TaskWidget? task;

  parseCreatedAtDate(inputDate) {
    String inputDateString = inputDate;

// Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(inputDateString);

// Create a custom date format
    DateFormat dateFormat = DateFormat('dd-MM-yyyy / HH:mm');

// Format the DateTime object as a string in the desired format
    String formattedDateString = dateFormat.format(dateTime);

    return formattedDateString; // Output: 22-09-2023 / 13:11
  }

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
            //Heading
            Text(
              task!.taskName,
              overflow: TextOverflow.ellipsis,
              style: kTaskTextStyle.copyWith(fontSize: 40),
            ),
            //Created By
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Created By: ${task!.createdBy} \nAt ${parseCreatedAtDate(task!.createdAt)}",
                  style: kHintTextStyle.copyWith(color: Colors.black),
                ),
                const SizedBox(width: 20),
                //Due by
                Text(
                  "Due By: ${task!.dueDate}",
                  style: kHintTextStyle.copyWith(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text("Description",
                style: kTaskTextStyle.copyWith(
                    fontSize: 20, fontStyle: FontStyle.italic)),
            const SizedBox(height: 5),
            Text(
              task!.description,
              style: kHintTextStyle,
            ),
          ],
        ),
      );
    }
  }
}
