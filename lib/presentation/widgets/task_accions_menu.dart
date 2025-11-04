import 'package:flutter/material.dart';

class TaskActionsMenu extends StatelessWidget {
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskActionsMenu({
    super.key,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'view') onView();
        if (value == 'edit') onEdit();
        if (value == 'delete') onDelete();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'view',
          child: Row(children: [
            Icon(Icons.visibility, color: Colors.blue, size: 20),
            SizedBox(width: 8),
            Text('Ver tarea', style: TextStyle(color: Colors.blue)),
          ]),
        ),
        const PopupMenuItem(
          value: 'edit',
          child: Row(children: [
            Icon(Icons.edit, color: Colors.orange, size: 20),
            SizedBox(width: 8),
            Text('Editar', style: TextStyle(color: Colors.orange)),
          ]),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(children: [
            Icon(Icons.delete, color: Colors.red, size: 20),
            SizedBox(width: 8),
            Text('Eliminar', style: TextStyle(color: Colors.red)),
          ]),
        ),
      ],
    );
  }
}
