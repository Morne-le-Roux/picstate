import 'dart:async';

import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/features/todo_list/presentation/widgets/task_info.dart';
import 'package:picstate/logic/logic.dart';

// Every task has little widgets that display the task name and functions that you can perform. This is that.

class OrderWidget extends StatefulWidget {
  const OrderWidget({
    super.key,
    required this.id,
    required this.orderName,
    required this.state,
    required this.index,
    required this.description,
    required this.visible,
    required this.createdAt,
    required this.createdBy,
  });

//The tasks name
  final int id;
  final String orderName;
  final String state;
  final String description;
  final int index;
  final bool visible;
  final String createdAt;
  final String createdBy;

//CODE FOR THE UNDO WHEN REMOVING A WIDGET
  Future<bool> showConfirmationSnackBar(BuildContext context) async {
    Completer<bool> completer = Completer<bool>();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
        content: const Text(
          "Deleting Order...",
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
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: const SizedBox(
        height: 70,
      ),
      visible: widget.visible,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                //TODO: Created dedicated Info Dialog for Orders.
                return TaskInfo(
                    taskName: widget.orderName,
                    description: widget.description,
                    createdAt: widget.createdAt,
                    createdBy: widget.createdBy,
                    dueDate: "temp",
                    state: widget.state);
              });
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Dismissible(
                //Dismissible settings
                key: ValueKey(widget.id),
                confirmDismiss: (direction) async {
                  bool confirmed =
                      await widget.showConfirmationSnackBar(context);
                  return confirmed;
                },
                direction: DismissDirection.horizontal,
                onDismissed: (direction) => Logic().deleteOrder(widget.id),

                //dismiss background
                background: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 223, 69, 59),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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

                        //Based on Task inedx in the listviewbuilder, will invert the gradient so the tasks separate a bit better in list view
                        begin: widget.index % 2 == 0
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        end: widget.index % 2 == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        //gradient color
                        colors:
                            widget.state == "todo" ? kColorTodo : kColorDone),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //TASK NAME and INFO
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.orderName,
                              style: kTaskTextStyle,
                            ),
                          ),
                        ),

                        //SIDE INFO
                        Row(
                          children: [
                            //DUE DATE

                            ConstrainedBox(
                              constraints:
                                  BoxConstraints.loose(const Size(100, 50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                            ),

                            //spacing

                            const SizedBox(
                              width: 20,
                            ),

                            //state BUTTON
                            PopupMenuButton(
                              onSelected: (value) =>
                                  Logic().updateOrderData(widget.id, value),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                const PopupMenuItem(
                                  value: "ToOrder",
                                  child: Text('To Order'),
                                ),
                                const PopupMenuItem(
                                  value: "Ordered",
                                  child: Text('Ordered'),
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
          ),
        ),
      ),
    );
  }
}
