import 'dart:async';

import 'package:flutter/material.dart';
import 'package:picstate/logic/constants.dart';
import 'package:picstate/custom_widgets/widget_info.dart';
import 'package:picstate/logic/logic.dart';

// Every task has little widgets that display the task name and functions that you can perform. This is that.

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.id,
    required this.taskName,
    required this.createdBy,
    required this.createdAt,
    required this.dueDate,
    required this.description,
    required this.state,
    required this.index,
  });

//The tasks name
  final int id;
  final String createdBy;
  final String taskName;
  final String createdAt;
  final String dueDate;
  final String state;
  final String description;
  final int index;

//CODE FOR THE UNDO WHEN REMOVING A WIDGET
  Future<bool> showConfirmationSnackBar(BuildContext context) async {
    Completer<bool> completer = Completer<bool>();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
        content: const Text(
          "Deleting Task...",
          style: TextStyle(color: Colors.black),
        ),
        action: SnackBarAction(
          label: "UNDO",
          textColor: Colors.black,
          onPressed: () {
            completer.complete(false); // User confirmed
          },
        ),
      ),
    );

    // Use a Timer to automatically complete with false after a timeout
    Timer(const Duration(seconds: 4), () {
      if (!completer.isCompleted) {
        completer.complete(true); // Timed out
      }
    });

    return completer.future;
  }

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return WidgetInfo(
                  taskName: widget.taskName,
                  description: widget.description,
                  createdAt: widget.createdAt,
                  createdBy: widget.createdBy,
                  dueDate: widget.dueDate,
                  state: widget.state);
            });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Dismissible(
            //Dismissible settings
            key: ValueKey(widget.id),
            confirmDismiss: (direction) async {
              bool confirmed = await widget.showConfirmationSnackBar(context);
              return confirmed;
            },
            direction: DismissDirection.horizontal,
            onDismissed: (direction) => Logic().deleteTask(widget.id),

            //dismiss background
            background: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 223, 69, 59),
              ),
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              //height of the widget
              height: 60,
              decoration: BoxDecoration(
                //gradient settings
                gradient: LinearGradient(

                    //Based on Task id, will invert the gradient so the tasks separate a bit better in list view
                    begin: widget.index % 2 == 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    end: widget.index % 2 == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    //gradient color
                    colors: widget.state == "todo"
                        ? widget.dueDate == today
                            ? kColorTodoToday
                            : kColorTodo
                        : widget.state == "order"
                            ? kColorToOrder
                            : widget.state == "waiting"
                                ? kColorWaiting
                                : kColorDone),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //TASK NAME and INFO
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 200,
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
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
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
                            Logic().updateData(widget.id, value),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            value: "todo",
                            child: Text('ToDo'),
                          ),
                          const PopupMenuItem(
                            value: "done",
                            child: Text('Done'),
                          ),
                          const PopupMenuItem(
                            value: "waiting",
                            child: Text('Waiting'),
                          ),
                          const PopupMenuItem(
                            value: "order",
                            child: Text('To Order'),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
