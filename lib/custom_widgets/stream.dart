import 'package:flutter/material.dart';
import 'task.dart';
import 'package:picstate/supabase_stuff.dart';
import 'package:simplified_flutter_animations/generic_fade_transition.dart';
import 'new_task.dart';
import 'rounded_button.dart';

class ListStream extends StatefulWidget {
  const ListStream({super.key});

  @override
  State<ListStream> createState() => _ListStreamState();
}

class _ListStreamState extends State<ListStream> {
  List<TaskWidget> tasks = []; //list of tasks that the listView uses
  final SupaBaseStuff _supaBaseStuff = SupaBaseStuff();
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              index: tasks.length,
            ));
          }

          //sort

          int customCompare(TaskWidget a, TaskWidget b) {
            final statesOrder = ["todo", "waiting", "order", "done"];
            return statesOrder
                .indexOf(a.state)
                .compareTo(statesOrder.indexOf(b.state));
          }

          tasks.sort(customCompare);

          //return

          return Stack(alignment: Alignment.bottomCenter, children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                    Colors.black,
                    Colors.black,
                    Colors.black,
                    Colors.black,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                margin: const EdgeInsets.only(),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return GenericFadeTransition(
                        curve: Curves.easeInOutCubicEmphasized,
                        duration: const Duration(milliseconds: 800),
                        builder: (context) {
                          return tasks[index];
                        });
                  },
                ),
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
            ),
          ]);
        },
      ),
    );
  }
}
