import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/task.dart';
import 'package:picstate/supabase_stuff.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskWidget> tasks = [];
  final SupaBaseDoStuff _supaBaseDoStuff = SupaBaseDoStuff();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: _supaBaseDoStuff.listenToTasks(),
              builder: (context, snapshot) {
//clears task list before building new list
                tasks = [];
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

//DECODE JSON DATA //wait... its not JSON!!!

//task list builder:

                for (var task in snapshot.data) {
                  tasks.add(TaskWidget(
                      id: task["id"].toString(),
                      taskName: task["task_name"],
                      createdBy: "Person",
                      createdAt: task["created_at"]));
                }

//return
                return ListView(
                  children: tasks,
                );
              },
            )),
      ),
    );
  }
}
