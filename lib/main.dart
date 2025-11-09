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

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

}

  class _MainAppState extends State<MainApp> {
    int selectedColor = 1;
    bool isDarkMode = false;

    void toggleTheme() {
      setState(() => isDarkMode = !isDarkMode);
    }

    void toggleDarkmode() {
      setState(() => isDarkMode = !isDarkMode);
    }

    void changeColor(int index) {
      setState(() => selectedColor = index);
    }

  @override
  Widget build(BuildContext context) {
    final repository = TaskRepositoryImpl(
      dataSource: TaskDataSource(),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: selectedColor, isDarkMode: false).getTheme(),
      darkTheme: AppTheme(selectedColor: selectedColor, isDarkMode: true).getTheme(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: TaskScreen(
        repository: repository,
        onToggleDarkmode: toggleDarkmode,
        isDarkmode: isDarkMode,
        selectedColor: selectedColor,
        onColorChanged: changeColor,
        ),
        
    );
  }
}
