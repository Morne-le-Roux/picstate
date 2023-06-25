import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/new_task.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/task.dart';
import 'package:picstate/supabase_stuff.dart';
import 'package:picstate/custom_widgets/top_bar.dart';
import 'package:simplified_flutter_animations/generic_fade_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//TODO: Fix a bug where after the app is minimized, the stream gets broken.
//Try implementing WidgetsBindingObserver to check when the app is resumed.

class _HomeScreenState extends State<HomeScreen> {
  List<TaskWidget> tasks = []; //list of tasks that the listView uses
  final SupaBaseStuff _supaBaseStuff = SupaBaseStuff();

  @override
  void initState() {
    super.initState();
    SupaBaseStuff().needsUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            const TopBar(), //yellow border line thingy.

//StreamBuilder
            Expanded(
              child: StreamBuilder(
                stream: _supaBaseStuff.listenToTasks(),
                builder: (context, snapshot) {
                  //clears task list before building new list
                  tasks = [];
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.amber,
                    ));
                  }
                  //DECODE JSON DATA //wait... its not JSON!!!

                  //task list builder:

                  for (var task in snapshot.data) {
                    tasks.add(TaskWidget(
                      id: task["id"],
                      taskName: task["task_name"],
                      description: task["description"],
                      createdBy: task["created_by"],
                      createdAt: task["created_at"],
                      dueDate: task["due_date"] ?? "No Due Date",
                      state: task["state"],
                    ));
                  }

                  //return
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return GenericFadeTransition(
                          curve: Curves.easeInOutCubicEmphasized,
                          duration: const Duration(milliseconds: 800),
                          builder: (context) {
                            return tasks[index];
                          });
                    },
                  );
                },
              ),
            ),

            //add task button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                text: "Add Task",
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const NewTask();
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
