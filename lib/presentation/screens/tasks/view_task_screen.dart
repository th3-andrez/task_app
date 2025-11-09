// lib/feature/task/presentation/screens/view_task_screen.dart
import 'package:flutter/material.dart';
import 'package:task_app/config/feature/tasks/task.dart';
class ViewTaskScreen extends StatelessWidget {
  final Task task;

  const ViewTaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Tarea'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TÍTULO
            Text(
              task.title,
              //cambios en el estilo
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? theme.disabledColor : null,
              ),
            ),
            const SizedBox(height: 16),

            // ESTADO
            Row(
              children: [
                //cambio de icono y color segun el estado
                Icon(
                  isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isCompleted
                    ? (isDark ? Colors.green[300] : Colors.green)
                    : (isDark ? Colors.orange[300] : Colors.orange),
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  isCompleted ? 'Completada' : 'Pendiente',
                  //cambio de style segun el estado y tema
                  style: TextStyle(
                    fontSize: 18,
                    color: isCompleted
                      ? (isDark ? Colors.green[300] : Colors.green)
                      : (isDark ? Colors.orange[300] : Colors.orange),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // DESCRIPCIÓN
            const Text(
              'Descripción:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                //cambio de color segun el tema si es dark o light
                color: isDark
                  ? theme.colorScheme.outline
                  : theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                    ? theme.colorScheme.onSurfaceVariant
                    : theme.colorScheme.onSurface,
                )
              ),
              child: Text(
                task.description ?? 'Sin descripción',
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: task.description != null
                    ? (isDark ? Colors.grey[400] : Colors.grey[600]): null,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ID (opcional)
            Text(
              'ID: ${task.id}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}