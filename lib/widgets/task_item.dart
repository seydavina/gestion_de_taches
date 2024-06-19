import 'package:flutter/material.dart';
import '../models/task.dart';
import '../constants/colors.dart';
import '../constants/style_text.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function onDelete;
  final Function onEdit;

  const TaskItem({
    required this.task,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title, style: AppTextStyles.title3),
        subtitle: Text(task.description, style: AppTextStyles.title4),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.blue),
              onPressed: () => onEdit(),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: AppColors.red),
              onPressed: () => onDelete(),
            ),
          ],
        ),
      ),
    );
  }
}
