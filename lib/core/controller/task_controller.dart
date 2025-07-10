class TaskController {
  List<String> tasks = [
    "Drink Water 💧",
    // "Meditate 🧘‍♀️",
    // "Walk 🚶‍♂️",
  ];

  void addTask(String newTask) {
    tasks.add(newTask);
  }
}
