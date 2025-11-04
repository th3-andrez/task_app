import '../entities/task_entities.dart';
import '../enums/task_status.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<Task> createTask(String title, [String? description]);
  Future<Task> updateTask(String id, String title, [String? description]);
  Future<Task> updateStatus(String id, TaskStatus status); //esta funcion funciona con el mismo endpoint que updateTask
  Future<void> deleteTask(String id);
}