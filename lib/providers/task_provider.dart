// lib/providers/task_provider.dart
import 'package:flutter/foundation.dart';

class TaskProvider extends ChangeNotifier {
  final List<String> _tasks = ["Drink Water 💧"];

  List<String> get tasks => _tasks;

  void addTasks(String task) {
    _tasks.add(task);
    notifyListeners(); // ✅ Make sure this is called
  }
}
