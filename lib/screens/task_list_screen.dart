import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  bool showCompleted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(showCompleted ? Icons.check_box : Icons.check_box_outline_blank),
            onPressed: () {
              setState(() {
                showCompleted = !showCompleted;
              });
            },
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          var tasks = taskProvider.filterTasks(showCompleted);
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index];
              return TaskTile(
                task: task,
                onEdit: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(task: task),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
