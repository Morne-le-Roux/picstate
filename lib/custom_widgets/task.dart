import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/supabase_stuff.dart';

// Every task has little widgets that display the task name and functions that you can perform. This is that.

class TaskWidget extends StatefulWidget {
  const TaskWidget(
      {super.key,
      required this.id,
      required this.taskName,
      required this.createdBy,
      required this.createdAt,
      required this.dueDate});

//The tasks name
  final int id;
  final String createdBy;
  final String taskName;
  final String createdAt;
  final String dueDate;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
//height of the widget
      height: 80,
      decoration: BoxDecoration(
//gradient settings
        gradient: LinearGradient(

//Based on Task id, will invert the gradient so the tasks separate a bit better in list view
            begin: widget.id % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.id % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
//gradient color
            colors: const [Colors.amber, Colors.amberAccent]),

//shadow cast
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 0))
        ],
//border of the widget

        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//TASK NAME and INFO
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  widget.taskName,
                  style: kTaskTextStyle,
                ),
              ),

//CREATED BY
              Text(
                "Created by: ${widget.createdBy}",
                style: kHintTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),

//SIDE INFO
          Row(
            children: [
//DUE DATE

              Text(
                "Due by: ",
                style: kTaskTextStyle,
              ),
              Text(
// Checks if due date is today
                widget.dueDate == today
                    ? "Today"
// Checks if due date is yesterday
                    : widget.dueDate == yesterday
                        ? "Yesterday"
// Checks if due date is tomorrow
                        : widget.dueDate == tomorrow
                            ? "Tomorrow"
// Otherwise prints due date
                            : widget.dueDate,
                style: kTaskTextStyle,
              ),

//X BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {
                    SupaBaseStuff().deleteData(widget.id);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
