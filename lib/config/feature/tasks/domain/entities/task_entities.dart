import 'package:task_app/config/feature/tasks/task.dart';

class Task {
    String id;
    String title;
    String? description;
    TaskStatus status;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: TaskStatus.fromApi(json['status']),
    );
  }
}