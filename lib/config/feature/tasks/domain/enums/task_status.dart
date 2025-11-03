enum TaskStatus {
  pending,
  completed;

  // Mapea desde API
  factory TaskStatus.fromApi(String value) {
    return TaskStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => TaskStatus.pending,
    );
  }

  // Para enviar (si necesitas)
  String toApi() => name.toUpperCase();
}