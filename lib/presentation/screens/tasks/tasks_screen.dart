import 'package:flutter/material.dart';
import 'package:task_app/presentation/widgets/create_task_buttun.dart';
import 'package:task_app/presentation/widgets/task_item_widget.dart';
import '../../../config/feature/tasks/task.dart';

class TaskScreen extends StatefulWidget {
  final TaskRepository repository;
  const TaskScreen({super.key, required this.repository});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    futureTasks = widget.repository.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tareas'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Task>>(
        future: futureTasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: MediaQuery.of(context).padding.bottom + 80,
              ),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskItemWidget(
                  task: task,
                  repository: widget.repository,     // ← PASA REPOSITORY
                  onUpdated: () => setState(() => _loadTasks()), // ← RECARGA
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: CreateTaskButton(
        repository: widget.repository,
        onTaskCreated: () => setState(() => _loadTasks()),
      ),
    );
  }
}