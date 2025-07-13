// lib/providers/task_provider.dart
import 'package:flutter/foundation.dart';

// task_provider.dart

class Task {
  final String activity;
  final String? notes;

  Task({required this.activity, this.notes});
}

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTasks(String activity, [String? notes]) {
    _tasks.add(Task(activity: activity, notes: notes));
    notifyListeners();
  }
}
