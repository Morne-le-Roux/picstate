import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Every task has little widgets that display the task name and functions that you can perform. This is that.

class Task extends StatefulWidget {
  const Task({super.key, required this.textData});

//The tasks name
  final String textData;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height of the widget
      height: 50,
      decoration: BoxDecoration(
        //color of the widget
        color: Colors.amber.shade700,

        //shadow cast
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(3, 3))
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
            child: Text(
              widget.textData,
              style: GoogleFonts.robotoCondensed(color: Colors.white),
            ),
          ),

//ICON X
//TODO: Implement X Button
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.close_rounded,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
