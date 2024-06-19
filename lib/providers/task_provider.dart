import 'package:flutter/material.dart';
import '../models/task.dart';
import '../database/database_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await DatabaseHelper().getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DatabaseHelper().insertTask(task.toMap());
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    await DatabaseHelper().updateTask(updatedTask.toMap());
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  Future<void> deleteTask(int taskId) async {
    await DatabaseHelper().deleteTask(taskId);
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  List<Task> filterTasksByCompletion(bool isCompleted) {
    return _tasks.where((task) => task.isCompleted == isCompleted).toList();
  }
}
