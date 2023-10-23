import 'package:flutter/material.dart';
import 'package:picstate/core/widgets/rounded_button.dart';
import 'package:picstate/core/widgets/text_input.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/logic/logic.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  late String _newOrderName;

  final String _createdBy = Logic().getUserName().toString();
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kBackgroundColor),
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//NEW TASK NAME
          Column(
            children: [
              TextInput(
                width: 500,
                icon: Icons.abc,
                hintText: "New Order Name",
                onChanged: (value) => _newOrderName = value,
                obscureText: false,
                fontColor: Colors.black,
              ),

//SPACING
              const SizedBox(
                height: 20,
              ),

//Description
              TextInput(
                width: 500,
                hintText: "Description",
                onChanged: (value) => _description = value,
                obscureText: false,
                fontColor: Colors.white,
                icon: Icons.description,
                multiline: true,
              )
            ],
          ),

//ADD TASK BUTTON

          RoundedButton(
            text: "Add Order",
            onTap: () {
              Logic().addOrder(_newOrderName, _createdBy, _description ?? "");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
