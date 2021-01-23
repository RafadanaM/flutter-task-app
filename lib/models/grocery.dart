class Grocery {
  final String title;
  bool isCompleted;

  Grocery({this.title, this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
