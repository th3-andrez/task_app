// lib/feature/task/presentation/widgets/create_task_button.dart
import 'package:flutter/material.dart';
import '../screens/tasks/crate_tasks_screen.dart';
import '../../config/feature/tasks/task.dart';

class CreateTaskButton extends StatelessWidget {
  final TaskRepository repository;
  final VoidCallback onTaskCreated; // Obligatorio

  const CreateTaskButton({
    super.key,
    required this.repository,
    required this.onTaskCreated,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateTaskScreen(repository: repository),
          ),
        );

        // Si se creó → llama al callback
        if (result == true) {
          onTaskCreated();
        }
      },
      tooltip: 'Crear nueva tarea',
      child: const Icon(Icons.add),
    );
  }
}