import 'package:flutter/material.dart';
import 'task_widget.dart';
import 'package:picstate/logic/logic.dart';
import 'package:simplified_flutter_animations/generic_slide_transition.dart';
import 'new_task.dart';
import '../../../../core/widgets/rounded_button.dart';

class ToDoStream extends StatefulWidget {
  const ToDoStream({super.key});

  @override
  State<ToDoStream> createState() => _ToDoStreamState();
}

class _ToDoStreamState extends State<ToDoStream> {
  List<TaskWidget> tasks = []; //list of tasks that the listView uses
  List<bool> tasksAnimated = []; //List to check if the task was animated before
  final Logic _logic = Logic();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _logic.taskStream(),
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

//adds a bool in tasksAnimated List to display animation or not.
            tasksAnimated.add(
              false,
            );
          }

          //adds extra bool for last "SpaceHolder"
          tasksAnimated.add(false);

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
                        milliseconds: index * 80); //delay between widgets

                    return FutureBuilder(
                      future: Future.delayed(tasksAnimated[
                              index] //checks if task was animated before
                          ? const Duration(milliseconds: 0)
                          : delay),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (!tasksAnimated[index]) {
                            //if task was not animated b4
                            return GenericSlideTransition(
                              initialOffset: const Offset(-5, 0),
                              curve: Curves.easeInOutCubicEmphasized,
                              duration: const Duration(
                                  milliseconds: 800), //animation load in speed
                              builder: (context) {
                                tasksAnimated[index] =
                                    true; //Marks the widget as animated
                                return tasks[index];
                              },
                            );
                          } else {
                            //if task was animated b4
                            return tasks[index];
                          }
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
