import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_app/config/feature/tasks/task.dart';
import 'package:task_app/config/theme/app_theme.dart';
import 'package:task_app/presentation/screens/tasks/tasks_screen.dart';

// Punto de entrada principal de la aplicación
Future<void> main() async {
  // Cargar variables de entorno desde el archivo .env
  await dotenv.load(fileName: ".env");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = TaskRepositoryImpl(
      dataSource: TaskDataSource(),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).getTheme(),
      home: TaskScreen(repository: repository),
    );
  }
}
