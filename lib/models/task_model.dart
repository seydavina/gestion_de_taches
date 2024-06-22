class Task {
  String id;
  String title;
  String description;
  String status;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.status});
}

class TaskModel {
  static final TaskModel _instance = TaskModel._internal();
  factory TaskModel() => _instance;

  TaskModel._internal();

  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(Task task) {
    _tasks.add(task);
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }
}
