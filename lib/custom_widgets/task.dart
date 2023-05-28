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
      required this.dueDate,
      required this.state});

//The tasks name
  final int id;
  final String createdBy;
  final String taskName;
  final String createdAt;
  final String dueDate;
  final String state;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      //height of the widget
      height: 80,
      decoration: BoxDecoration(
        //gradient settings
        gradient: LinearGradient(

            //Based on Task id, will invert the gradient so the tasks separate a bit better in list view
            begin: widget.id % 2 == 0
                ? Alignment.centerRight
                : Alignment.centerLeft,
            end: widget.id % 2 == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            //gradient color
            colors: widget.state == "todo"
                ? const [Colors.amber, Colors.amberAccent]
                : const [Colors.green, Colors.greenAccent]),

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
      child: Dismissible(
//dismissible settings
        key: ValueKey(widget.id),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) => SupaBaseStuff().deleteData(widget.id),

//dismiss background
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 69, 59),
              borderRadius: BorderRadius.circular(20)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.delete_rounded,
                color: Colors.white,
              ),
              Icon(
                Icons.delete_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TASK NAME and INFO
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.taskName,
                    style: kTaskTextStyle,
                  ),

                  //spacing

                  const SizedBox(
                    height: 5,
                  ),

                  //CREATED BY
                  Text(
                    "Created by: ${widget.createdBy}",
                    style: kHintTextStyle.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            //SIDE INFO
            Row(
              children: [
                //DUE DATE

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
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
                      ],
                    ),

                    //SPACING
                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      "Status: ${widget.state}",
                      style: kTaskTextStyle,
                    )
                  ],
                ),

                //spacing

                const SizedBox(
                  width: 20,
                ),

                //state BUTTON
                PopupMenuButton(
                  onSelected: (value) =>
                      SupaBaseStuff().updateData(widget.id, value),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      value: "todo",
                      child: Text('todo'),
                    ),
                    const PopupMenuItem(
                      value: "done",
                      child: Text('done'),
                    ),
                    const PopupMenuItem(
                      value: "waiting",
                      child: Text('waiting'),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
