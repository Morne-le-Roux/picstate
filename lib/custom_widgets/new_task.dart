import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/supabase_stuff.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String _newTaskName = "";
  late String _dueDate;
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
            onChanged: (value) => _newTaskName = value,
            obscureText: false,
            fontColor: Colors.black,
          ),

//DUE DATE PICKER

          TimePickerSpinnerPopUp(
            mode: CupertinoDatePickerMode.date,
            initTime: DateTime.now(),
            barrierColor: Colors.black12,
            timeFormat: "dd/MM/yyyy",
            timeWidgetBuilder: (p0) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Text(p0.toString()),
              );
            },
          ),

//ADD TASK BUTTON

          RoundedButton(
            text: "Add Task",
            onTap: () {
              SupaBaseStuff().addData(_newTaskName, _dueDate.toString());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
