import '../../domain/entities/task_entities.dart';
import '../../domain/repository/task_repository.dart';
import '../datasouce/task_datasouce.dart';

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
}