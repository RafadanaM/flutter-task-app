class Task {
  final String title;
  final String description;
  final DateTime date;
  final DateTime reminder;
  bool isCompleted;

  Task(
      {this.title,
      this.description,
      this.date,
      this.reminder,
      this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
