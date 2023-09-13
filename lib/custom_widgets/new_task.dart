import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/logic_and_streams/logic.dart';

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
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black87, Colors.black],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft)),
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//NEW TASK NAME
          Column(
            children: [
              BasicTextField(
                width: 500,
                icon: Icons.abc,
                hintText: "New Task Name",
                onChanged: (value) => _newTaskName = value,
                obscureText: false,
                fontColor: Colors.white,
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
                dayTextStyle:
                    const TextStyle(fontSize: 8, color: Colors.white70),
                monthTextStyle:
                    const TextStyle(fontSize: 8, color: Colors.white70),
                dateTextStyle:
                    const TextStyle(fontSize: 24, color: Colors.white70),
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
              BasicTextField(
                width: 500,
                hintText: "Description",
                onChanged: (value) => _description = value,
                obscureText: false,
                fontColor: Colors.white,
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
