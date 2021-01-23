class Task {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime reminder;
  bool isCompleted;
  bool isChecked;

  Task(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.reminder,
      this.isChecked = false,
      this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  void toggleChecked() {
    isChecked = !isChecked;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'reminder': reminder == null ? "no reminder" : reminder.toIso8601String(),
      'isChecked': isChecked ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
