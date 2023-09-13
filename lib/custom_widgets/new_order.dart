import 'package:flutter/material.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
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
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black87, Colors.black],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft)),
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//NEW TASK NAME
          Column(
            children: [
              BasicTextField(
                width: 500,
                icon: Icons.abc,
                hintText: "New Order Name",
                onChanged: (value) => _newOrderName = value,
                obscureText: false,
                fontColor: Colors.white,
              ),

//SPACING
              const SizedBox(
                height: 20,
              ),

//Description
              BasicTextField(
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
