import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),  // Ajoute const
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Ajoute const
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),  // Ajoute const
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),  // Ajoute const
            ),
            const SizedBox(height: 20),  // Ajoute const
            ElevatedButton(
              onPressed: () {
                final String id = Uuid().v4();
                final String title = _titleController.text;
                final String description = _descriptionController.text;
                final newTask = Task(
                  id: id,
                  title: title,
                  description: description,
                );
                Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                Navigator.of(context).pop();
              },
              child: const Text('Add Task'),  // Ajoute const
            ),
          ],
        ),
      ),
    );
  }
}
