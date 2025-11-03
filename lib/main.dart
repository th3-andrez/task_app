import 'package:flutter/material.dart';
import 'package:task_app/config/feature/task/task.dart';
import 'package:task_app/config/theme/app_theme.dart';
import 'package:task_app/presentation/screens/taks/taks_screen.dart';

void main() {
  runApp(const  MainApp());
}

class MainApp extends StatelessWidget{
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
      const String apiUrl = 'http://192.168.1.8:3000'; // Reemplaza con la URL de tu API
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme(selectedColor: 4).getTheme(),
            home: TaskScreen(dataSource: TaskDataSourceImpl(baseUrl: apiUrl),)
        );
    }
}