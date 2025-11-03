import 'package:flutter/material.dart';
import '../../../config/feature/task/task.dart';


class TaskScreen extends StatefulWidget {
  final TaskDataSource dataSource;

  const TaskScreen({super.key, required this.dataSource});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = widget.dataSource.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Tareas')),
      body: FutureBuilder<List<Task>>(
        future: futureTasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: task.description != null ? Text(task.description!) : null,
                  trailing: Icon(
                    task.status == 'COMPLETED' ? Icons.check_circle : Icons.circle_outlined,
                    color: task.status == 'COMPLETED' ? Colors.green : Colors.grey,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}