import '../../domain/entities/task_entities.dart';
import '../../domain/repository/task_repository.dart';
import '../datasouce/task_datasouce.dart';
import '../../domain/enums/task_status.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource dataSource;

  TaskRepositoryImpl({required this.dataSource});

  @override
  Future<List<Task>> getAllTasks() {
    return dataSource.getAllTasks(); // SIN async/await
  }

  @override
  Future<Task> createTask(String title, [String? description]) {
    return dataSource.createTask(title, description);
  }

  @override
  Future<Task> updateTask(String id, String title, [String? description]) {
    return dataSource.updateTask(id, title, description);
  }

  @override
Future<Task> updateStatus(String id, TaskStatus status) {
  return dataSource.updateStatus(id, status);
}
}