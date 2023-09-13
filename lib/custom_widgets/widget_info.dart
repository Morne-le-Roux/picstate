import 'package:flutter/material.dart';
import 'package:picstate/logic/constants.dart';

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
        borderRadius: BorderRadius.circular(20),
        color: Colors.black87,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
//HEADING / TASK NAME
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(20)),
            child: Text(
              taskName,
              style: kTaskTextStyle.copyWith(fontSize: 30, color: Colors.white),
            ),
          ),

//SPACING
          const SizedBox(height: 20),

//DESCRIPTION
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white)),
            child: Text(
              description,
              style: kTaskTextStyle.copyWith(color: Colors.white),
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
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                child: Text(
                  "Created by: $createdBy",
                  style: kTaskTextStyle.copyWith(color: Colors.white),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                child: Text(
                  "State: $state",
                  style: kTaskTextStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
