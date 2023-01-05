import 'package:flutter/material.dart';
import 'package:picstate/custom_widgets/text_input.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String newTaskName = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          BasicTextField(
              hintText: "Task Name",
              onChanged: (value) => newTaskName = value,
              obscureText: false)
        ],
      ),
    );
  }
}
