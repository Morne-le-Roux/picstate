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
      color: Colors.amber,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//NEW TASK NAME
          Column(
            children: [
              BasicTextField(
                hintText: "New Task Name",
                onChanged: (value) => _newTaskName = value,
                obscureText: false,
                fontColor: Colors.black,
              ),

//DUE DATE PICKER

              DatePicker(
                DateTime.now(),
                daysCount: 365,
                dayTextStyle: const TextStyle(fontSize: 5),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
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
