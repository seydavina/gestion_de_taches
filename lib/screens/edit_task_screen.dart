import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;

  EditTaskScreen({required this.task, Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = task.title;
    _descriptionController.text = task.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedTask = Task(
                  id: task.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  isCompleted: task.isCompleted,
                );
                Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);
                Navigator.of(context).pop();
              },
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
