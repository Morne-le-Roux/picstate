import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/core/widgets/rounded_button.dart';
import 'package:picstate/core/widgets/text_input.dart';
import 'package:picstate/logic/logic.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  late String _newTaskName;
  late String _dueDate;
  final String _createdBy = Logic().getUserName().toString();
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kBackgroundColor),
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//NEW TASK NAME
          Column(
            children: [
              TextInput(
                width: 500,
                icon: Icons.abc,
                hintText: "New Task Name",
                onChanged: (value) => _newTaskName = value,
                obscureText: false,
                fontColor: Colors.black,
              ),

//SPACING
              const SizedBox(
                height: 20,
              ),

//DUE DATE PICKER

              Text(
                "Due Date",
                style: kTaskTextStyle.copyWith(color: Colors.white70),
              ),

              DatePicker(
                DateTime.now(),
                daysCount: 365,
                dayTextStyle: const TextStyle(fontSize: 8, color: Colors.black),
                monthTextStyle:
                    const TextStyle(fontSize: 8, color: Colors.black),
                dateTextStyle:
                    const TextStyle(fontSize: 24, color: Colors.black),
                selectionColor: Colors.yellow,
                selectedTextColor: Colors.black,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _dueDate = DateFormat("dd MMM").format(date);
                  });
                },
              ),

              const SizedBox(
                height: 20,
              ),
//Description
              TextInput(
                width: 500,
                hintText: "Description",
                onChanged: (value) => _description = value,
                obscureText: false,
                fontColor: Colors.black,
                icon: Icons.description,
                multiline: true,
              )
            ],
          ),

//TODO: ADD STATE OPTION WHEN CREATING TASK.
          const Row(
            children: [],
          ),

//ADD TASK BUTTON

          RoundedButton(
            text: "Add Task",
            onTap: () {
              Logic().addTask(_newTaskName, _dueDate.toString(), _createdBy,
                  _description ?? "");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
