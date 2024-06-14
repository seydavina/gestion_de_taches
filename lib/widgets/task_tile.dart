import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task, Key? key}) : super(key: key);  // Ajoute le paramètre key

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          Provider.of<TaskProvider>(context, listen: false).toggleTaskCompletion(task.id);
        },
      ),
    );
  }
}

