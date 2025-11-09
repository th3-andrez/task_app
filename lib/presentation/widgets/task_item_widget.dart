import 'package:flutter/material.dart';
import 'package:task_app/config/feature/tasks/task.dart';
import 'package:task_app/presentation/screens/tasks/edit_tasks_screen.dart';
import 'package:task_app/presentation/screens/tasks/view_task_screen.dart';
import 'package:task_app/presentation/widgets/task_accions_menu.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final TaskRepository repository;
  final VoidCallback onUpdated; 

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.repository,
    required this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;
    final theme = Theme.of(context);


    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        //checkbox para marcar como completada o pendiente
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
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
              }
            } 
          },
        ),

        title: Text(
          task.title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            //color del  tema
            color: isCompleted ? theme.disabledColor : null,
            fontWeight: FontWeight.w500,
          ),
        ),
        //subtitle si tiene descripcion
        subtitle: task.description != null
            ? Text(
                task.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                //cambio al color del tema de la descripcion
                style: TextStyle(
                  color: isCompleted ? theme.disabledColor:theme.textTheme.bodyMedium?.color,
                ),
              )
            : null,
            //menu de acciones
        trailing: TaskActionsMenu(
          onView: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewTaskScreen(task: task),
              ),
            );
          },
          //editar tarea
          onEdit: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditTaskScreen(task: task, repository: repository),
              ),
            );
            if (result == true) onUpdated();
          },
          //eliminar tarea
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('¿Eliminar tarea?'),
                content: Text('"${task.title}" se eliminará permanentemente.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Eliminar'),
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
                    const SnackBar(content: Text('Tarea eliminada'), backgroundColor: Colors.green),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
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
