import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({
    super.key,
    required this.taskName,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.dueDate,
    required this.state,
  });

  final String createdBy;
  final String taskName;
  final String createdAt;
  final String dueDate;
  final String state;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
//HEADING / TASK NAME
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              taskName,
              style: kTaskTextStyle.copyWith(fontSize: 30),
            ),
          ),

//SPACING
          const SizedBox(height: 20),

//DESCRIPTION
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              description,
              style: kTaskTextStyle,
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
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: Text("Created by: $createdBy"),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: Text("State: $state"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
