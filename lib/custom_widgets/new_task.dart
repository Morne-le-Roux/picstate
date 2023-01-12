import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/supabase_stuff.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  late String _newTaskName;
  late String _dueDate;
  final String _createdBy = SupaBaseStuff().getUserName().toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.amber.shade700,
        Colors.amber.shade400,
      ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//NEW TASK NAME
          Column(
            children: [
              BasicTextField(
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

              DatePicker(
                DateTime.now(),
                daysCount: 365,
                dayTextStyle: const TextStyle(fontSize: 8),
                selectionColor: Colors.white,
                selectedTextColor: Colors.black,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _dueDate = DateFormat("dd MMM").format(date);
                  });
                },
              ),
            ],
          ),

//ADD TASK BUTTON

          RoundedButton(
            text: "Add Task",
            onTap: () {
              SupaBaseStuff()
                  .addData(_newTaskName, _dueDate.toString(), _createdBy);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
