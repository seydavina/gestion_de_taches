import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/task_list_screen.dart';
import 'providers/task_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        home: TaskListScreen(),
      ),
    );
  }
}
