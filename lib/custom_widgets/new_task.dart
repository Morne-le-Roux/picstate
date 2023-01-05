import 'package:flutter/material.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/supabase_stuff.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//NEW TASK NAME
          BasicTextField(
              hintText: "New Task Name",
              onChanged: (value) => newTaskName = value,
              obscureText: false),

//ADD TASK BUTTON

          RoundedButton(
            text: "Add Task",
            onTap: () {
              SupaBaseStuff().addData(newTaskName);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
