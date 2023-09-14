import 'package:flutter/material.dart';
import '../custom_widgets/task.dart';
import 'package:picstate/logic/logic.dart';
import 'package:simplified_flutter_animations/generic_slide_transition.dart';
import '../custom_widgets/new_task.dart';
import '../custom_widgets/rounded_button.dart';

class ToDoStream extends StatefulWidget {
  const ToDoStream({super.key});

  @override
  State<ToDoStream> createState() => _ToDoStreamState();
}

class _ToDoStreamState extends State<ToDoStream> {
  List<TaskWidget> tasks = []; //list of tasks that the listView uses
  final Logic _supaBaseStuff = Logic();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _supaBaseStuff.taskStream(),
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
              visible: true,
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

          tasks.add(const TaskWidget(
              id: -1,
              taskName: "",
              createdBy: "",
              createdAt: "",
              dueDate: "",
              description: "",
              state: "",
              index: 99999,
              visible: false));

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
                    final delay = Duration(
                        milliseconds: index * 100); //delay between widgets

                    return FutureBuilder(
                      future: Future.delayed(delay),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return GenericSlideTransition(
                            initialOffset: const Offset(-5, 0),
                            curve: Curves.easeInOutCubicEmphasized,
                            duration: const Duration(milliseconds: 1000),
                            builder: (context) {
                              return tasks[index];
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
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
