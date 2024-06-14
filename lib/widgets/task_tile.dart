import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;

  TaskTile({required this.task, required this.onEdit, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              Provider.of<TaskProvider>(context, listen: false).toggleTaskCompletion(task.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
