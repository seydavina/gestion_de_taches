import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    var index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void toggleTaskCompletion(String id) {
    var task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  List<Task> filterTasks(bool showCompleted) {
    return showCompleted
        ? _tasks
        : _tasks.where((task) => !task.isCompleted).toList();
  }
}
