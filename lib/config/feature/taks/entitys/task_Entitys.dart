class Task {
   String id;
   String title;
   String? description;
   String status;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }
}