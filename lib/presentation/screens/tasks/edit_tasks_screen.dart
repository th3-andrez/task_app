// lib/feature/task/presentation/screens/edit_task_screen.dart
import 'package:flutter/material.dart';
import 'package:task_app/config/feature/tasks/task.dart';
import 'package:task_app/presentation/widgets/task_text_field.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final TaskRepository repository;

  const EditTaskScreen({
    super.key,
    required this.task,
    required this.repository,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final _titleCtrl = TextEditingController(text: widget.task.title);
  late final _descCtrl = TextEditingController(text: widget.task.description ?? '');
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      await widget.repository.updateTask(
        widget.task.id,
        _titleCtrl.text.trim(),
        _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarea actualizada'), backgroundColor: Colors.green),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Tarea'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TÍTULO
              TaskTextField(
                controller: _titleCtrl,
                label: 'Título',
                hint: 'Ej: Comprar leche',
                icon: Icons.title,
                required: true,
              ),
              const SizedBox(height: 16),

              // DESCRIPCIÓN
              TaskTextField(
                controller: _descCtrl,
                label: 'Descripción',
                hint: 'Detalles...',
                icon: Icons.description,
                maxLines: 4,
              ),
              const SizedBox(height: 32),

              // BOTÓN
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _loading ? null : _save,
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Guardar Cambios', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}