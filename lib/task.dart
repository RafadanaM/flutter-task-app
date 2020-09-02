class Task {
  final String title;
  final String description;
  final String date;
  bool isCompleted;

  Task({this.title, this.description, this.date, this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
