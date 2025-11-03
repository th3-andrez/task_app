import 'package:flutter/material.dart';
import 'package:task_app/config/feature/tasks/task.dart';
import 'package:task_app/config/theme/app_theme.dart';
import 'package:task_app/presentation/screens/tasks/tasks_screen.dart';

void main() {
  runApp(const  MainApp());
}

class MainApp extends StatelessWidget{
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
      const String apiUrl = 'http://192.168.1.8:3000'; // Reemplaza con la URL de tu API

      //uso del repositorio
      final repository = TaskRepositoryImpl(
        dataSource: TaskDataSource(baseUrl: apiUrl),
      );
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme(selectedColor: 4).getTheme(),
            home: TaskScreen(repository: repository)
        );
    }
}