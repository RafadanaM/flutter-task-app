class Task {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime reminder;
  final String reminderAsText;
  bool isCompleted;

  Task(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.reminderAsText,
      this.reminder,
      this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'reminderAsText': reminderAsText == null ? "no reminder" : reminderAsText,
      'reminder': reminder == null ? "no reminder" : reminder.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
