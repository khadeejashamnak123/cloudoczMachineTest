class Task {
  final int id;
  final String name;
  final String description;
  final int percentage;
  final String status;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.percentage,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      percentage: json['percentage'] as int,
      status: json['status'] as String,
    );
  }
}
