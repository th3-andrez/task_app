import 'package:flutter/material.dart';
import 'package:task_app/config/feature/tasks/task.dart';
import 'package:task_app/presentation/screens/tasks/edit_tasks_screen.dart';
import 'package:task_app/presentation/widgets/task_accions_menu.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final TaskRepository repository;
  final VoidCallback onUpdated; // ← AÑADE ESTO

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.repository,
    required this.onUpdated, // ← Y AQUÍ
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: (value) async {
            final newStatus = value == true
                ? TaskStatus.completed
                : TaskStatus.pending;
            try {
              await repository.updateStatus(task.id, newStatus);

              if (context.mounted) {
                onUpdated();
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al actualizar el estado: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } // ← LLAMA AL CALLBACK
          },
        ),

        title: Text(
          task.title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: task.description != null
            ? Text(
                task.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: TaskActionsMenu(
          onEdit: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    EditTaskScreen(task: task, repository: repository),
              ),
            );
            if (result == true) {
              onUpdated(); // ← LLAMA AL CALLBACK
            }
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Confirmar eliminación'),
                content: Text(
                  '¿Estás seguro de que deseas eliminar esta tarea ${task.title}?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Tarea Eliminada'),
                  ),
                ],
              ),
            );
            if (confirm == true && context.mounted) {
              try {
                await repository.deleteTask(task.id);
                if (context.mounted) {
                  onUpdated();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tarea eliminada correctamente'),
                      backgroundColor: Colors.green),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al eliminar la tarea: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            }
          },
        ),
      ),
    );
  }
}
