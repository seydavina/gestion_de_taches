import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  // List to store tasks
  List<Task> _tasks = [];

  // Getter to access the list of tasks
  List<Task> get tasks => [..._tasks];

  // Method to add a new task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Method to edit an existing task
  void editTask(String id, Task newTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = newTask;
      notifyListeners();
    }
  }

  // Method to delete a task
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // Method to get tasks by filter (e.g., completed or not)
  List<Task> getFilteredTasks(bool isCompleted) {
    return _tasks.where((task) => task.isCompleted == isCompleted).toList();
  }
}
