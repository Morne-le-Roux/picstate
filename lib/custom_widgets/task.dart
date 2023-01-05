import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picstate/supabase_stuff.dart';

// Every task has little widgets that display the task name and functions that you can perform. This is that.

class TaskWidget extends StatefulWidget {
  const TaskWidget(
      {super.key,
      required this.id,
      required this.taskName,
      required this.createdBy,
      required this.createdAt});

//The tasks name
  final int id;
  final String createdBy;
  final String taskName;
  final String createdAt;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
//height of the widget
        height: 50,
        decoration: BoxDecoration(
//color of the widget
          color: Colors.amber.shade400,

//shadow cast
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(2, 2))
          ],
//border of the widget
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
//TASK NAME
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.taskName,
                    style: GoogleFonts.robotoCondensed(color: Colors.white),
                  ),

//!UNIQUE ID (FOR DEV)
                  Text(
                    (widget.id).toString(),
                    style: const TextStyle(color: Colors.black45, fontSize: 8),
                  ),
                ],
              ),
            ),

//X Button
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
            )

//Calendar
          ],
        ),
      ),
    );
  }
}
