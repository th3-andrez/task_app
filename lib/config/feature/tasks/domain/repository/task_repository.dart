import '../entities/task_entities.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<Task> createTask(String title, [String? description]);
}