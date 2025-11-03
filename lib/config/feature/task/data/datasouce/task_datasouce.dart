import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_app/config/feature/task/domain/entitys/task_Entitys.dart';

abstract class TaskDataSource {
  Future<List<Task>> getAllTasks();
}

class TaskDataSourceImpl implements TaskDataSource {
  final String baseUrl;

  TaskDataSourceImpl({required this.baseUrl});

  @override
  Future<List<Task>> getAllTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    }

    throw Exception('Error al cargar tareas: ${response.statusCode}');
  }
}