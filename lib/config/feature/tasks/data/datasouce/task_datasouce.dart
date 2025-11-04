import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_app/config/feature/tasks/domain/entities/task_entities.dart';
import 'package:task_app/config/feature/tasks/domain/enums/task_status.dart';
import 'package:task_app/config/api_config.dart';

class TaskDataSource {
  final String baseUrl = ApiConfig.baseUrl;

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

  Future<Task> updateTask(String id, String title, [String? description]) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        if (description != null) 'description': description,
      }),
    );

    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Tarea no encontrada');
    } else {
      throw Exception('Error al actualizar: ${response.statusCode}');
    }
  }

  Future<Task> updateStatus(String id, TaskStatus status) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status.toApi()}), // "COMPLETED"
    );

    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    }
    throw Exception('Error al actualizar estado');
  }

  Future<void> deleteTask(String id) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/tasks/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception('Error al eliminar: ${response.statusCode}');
  }
}
}