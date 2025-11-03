import 'package:flutter/material.dart';
import 'package:task_app/config/feature/tasks/task.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        // ICONO DE ESTADO (solo visual)
        leading: Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.green : Colors.grey,
        ),

        // TÍTULO
        title: Text(
          task.title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : null,
            fontWeight: FontWeight.w500,
          ),
        ),

        // DESCRIPCIÓN
        subtitle: task.description != null
            ? Text(
                task.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isCompleted ? Colors.grey : null,
                ),
              )
            : null,

        // ICONO FINAL (opcional)
        trailing: isCompleted
            ? const Text(
                'Completada',
                style: TextStyle(color: Colors.green, fontSize: 12),
              )
            : null,
      ),
    );
  }
}