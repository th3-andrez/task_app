import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_app/config/feature/task/domain/entities/task_entities.dart';

class TaskDataSource {
  final String baseUrl;

  TaskDataSource({required this.baseUrl});

  Future<List<Task>> getAllTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    }
    throw Exception('Error: ${response.statusCode}');
  }

  Future<Task> createTask(String title, [String? description]) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        if (description != null) 'description': description,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    }
    throw Exception('Error al crear');
  }
}