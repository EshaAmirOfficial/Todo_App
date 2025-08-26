enum TaskStatus{all,pending,completed}
class TodoModel {
  final String title;
  final String description;
  final String category;
  final String priority;
  final DateTime time;
  final TaskStatus isCompleted;

  TodoModel({
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.time,
    required this.isCompleted,
  });
}