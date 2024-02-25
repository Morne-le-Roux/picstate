import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';
import 'package:intl/intl.dart';
import 'package:picstate/logic/logic.dart';

class TaskInfo extends StatelessWidget {
  TaskInfo({
    super.key,
    required this.id,
    required this.taskName,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.dueDate,
    required this.state,
  });

  final int id;
  final String createdBy;
  final String taskName;
  final String createdAt;
  final String dueDate;
  final String state;
  final String description;

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  parseCreatedAtDate(inputDate) {
    String inputDateString = inputDate;

// Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(inputDateString);

// Create a custom date format
    DateFormat dateFormat = DateFormat('dd-MM-yyyy / HH:mm');

// Format the DateTime object as a string in the desired format
    String formattedDateString = dateFormat.format(dateTime);

    return formattedDateString; // Output: 22-09-2023 / 13:11
  }

  final Logic _logic = Logic();

  @override
  Widget build(BuildContext context) {
    //init controller text
    _taskNameController.text = taskName;
    _descriptionController.text = description;
    _dueDateController.text = dueDate;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _logic.updateTaskName(id, _taskNameController.text);
          _logic.updateTaskDescription(id, _descriptionController.text);
          Navigator.pop(context);
        },
        backgroundColor: Colors.amber,
        splashColor: kBackgroundColor,
        child: const Icon(Icons.check),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //HEADING / TASK NAME
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(border: InputBorder.none),
                controller: _taskNameController,
                style: kTaskTextStyle.copyWith(
                    fontSize: 40,
                    color: const Color.fromARGB(223, 255, 255, 255)),
              ),
            ),

            //DESCRIPTION
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              height: 200,
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kBoxBorderColor)),
              child: TextField(
                maxLines: 20,
                decoration: const InputDecoration(border: InputBorder.none),
                controller: _descriptionController,
                style: kTaskTextStyle.copyWith(color: kBoxTextColor),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                      color: kBoxBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kBoxBorderColor)),
                  child: Text(
                    "Created by: $createdBy",
                    style: kTaskTextStyle.copyWith(color: kBoxTextColor),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                      color: kBoxBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kBoxBorderColor)),
                  child: Text(
                    "State: $state",
                    style: kTaskTextStyle.copyWith(color: kBoxTextColor),
                  ),
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              decoration: BoxDecoration(
                  color: kBoxBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kBoxBorderColor)),
              child: Text(
                "Created at: ${parseCreatedAtDate(createdAt)}",
                style: kTaskTextStyle.copyWith(color: kBoxTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
