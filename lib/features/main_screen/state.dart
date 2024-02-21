import "package:flutter/material.dart";
import "package:picstate/features/todo_list/presentation/widgets/task_widget.dart";

class TaskSelectedProvider extends ChangeNotifier {
  TaskWidget? selectedTask;

  setSelectedTask(TaskWidget task) {
    selectedTask = task;

    notifyListeners();
  }

  removeCurrentSelectedTask() {
    selectedTask = null;
    notifyListeners();
  }
}
