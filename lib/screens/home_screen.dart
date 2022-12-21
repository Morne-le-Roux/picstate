import 'package:flutter/material.dart';
import 'package:picstate/custom_widgets/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasklist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _tasklist.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: _tasklist[index],
                );
              },
            )),
      ),
    );
  }
}
