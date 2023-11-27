import 'dart:async';

import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/features/main_screen/state.dart';
import 'package:picstate/features/todo_list/presentation/widgets/task_info.dart';
import 'package:picstate/logic/logic.dart';
import 'package:provider/provider.dart';

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
    required this.visible,
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
  final bool visible;

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
    Timer(const Duration(seconds: 2), () {
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
  bool desktopMode = false;

  @override
  Widget build(BuildContext context) {
    //gets screen width and ajusts desktopMode
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 700) {
      desktopMode = true;
    }
    if (screenWidth <= 699) {
      desktopMode = false;
    }
    return Visibility(
      //empty space at bottom of list
      replacement: const SizedBox(
        height: 70,
      ),
      visible: widget.visible,
      child: GestureDetector(
        onTap: () {
          if (!desktopMode) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TaskInfo(
                    taskName: widget.taskName,
                    description: widget.description,
                    createdAt: widget.createdAt,
                    createdBy: widget.createdBy,
                    dueDate: widget.dueDate,
                    state: widget.state);
              },
            );
          } else {
            var selectedTaskProvider = context.read<TaskSelectedProvider>();
            selectedTaskProvider.setSelectedTask(widget);
          }
        },
        child: Material(
          elevation: 5,
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
              duration: const Duration(milliseconds: 1000),
              padding: const EdgeInsets.all(4), //BORDER WIDTH
              //height of the widget
              height: 60,
              decoration: BoxDecoration(
                //gradient settings
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.taskName,
                            style: kTaskTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.loose(const Size(120, 50)),
                            child: Row(
                              children: [
                                Text("Due by: ",
                                    style: kHintTextStyle.copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    )),
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
                                    style: kHintTextStyle.copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),

                          //SPACING
                          const SizedBox(
                            height: 5,
                          ),

                          Text("Status: ${widget.state}",
                              style: kHintTextStyle.copyWith(
                                fontSize: 12,
                                color: Colors.black,
                              ))
                        ],
                      ),

                      //spacing

                      const SizedBox(
                        width: 20,
                      ),

                      //state BUTTON
                      PopupMenuButton(
                        onSelected: (value) =>
                            Logic().updateTaskData(widget.id, value),
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
