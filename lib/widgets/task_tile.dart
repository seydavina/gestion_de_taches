import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task});

  void _toggleTaskCompletion(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.editTask(
      task.id,
      Task(
        id: task.id,
        title: task.title,
        description: task.description,
        isCompleted: !task.isCompleted,
      ),
    );
  }

  void _editTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: task),
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.deleteTask(task.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Wrap(
        spacing: 12,
        children: <Widget>[
          Checkbox(
            value: task.isCompleted,
            onChanged: (value) => _toggleTaskCompletion(context),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editTask(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteTask(context),
          ),
        ],
      ),
    );
  }
}
