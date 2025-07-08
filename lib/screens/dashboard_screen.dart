import 'dart:async';
import 'package:daily_wellness/core/constants/constant.dart';
import 'package:daily_wellness/core/widgets/add_activity_screen.dart';
import 'package:daily_wellness/providers/task_provider.dart';
import 'package:daily_wellness/services/api/quote_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Implemented using useSatet *********
// import 'package:daily_wellness/core/controller/task_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "Pooja";
  String currentTime = "";
  String quote = "Loading quote...";
  String author = "";
  //  implemented using useState *********8
  // final List<String> tasks = ["Drink Water 💧", "Meditate 🧘‍♀️", "Walk 🚶‍♂️"];
  // final TaskController _taskController = TaskController();
  @override
  void initState() {
    super.initState();
    _updateTime();
    _fetchQuote();
    Timer.periodic(const Duration(seconds: 60), (timer) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      currentTime =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} - ${now.day}/${now.month}/${now.year}";
    });
  }

  Future<void> _fetchQuote() async {
    final result = await QuoteService.fetchQuoteOfTheDay();
    setState(() {
      quote = result['quote']!;
      author = result['author']!;
    });
  }

  void _navigateToAddActivity() async {
    final result = await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Add Activity",
      barrierColor: Colors.black.withOpacity(0.22),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const AddActivityScreen();
      },
    );

    if (result != null) {
      final data = result as Map<String, dynamic>;
      if (data['activity'] != null) {
        setState(() {
          //  implemented using useState *********
          // _taskController.addTask(data['activity']);
          Provider.of<TaskProvider>(
            context,
            listen: false,
          ).addTasks(data['activity']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        // ✅ SafeArea added here
        child: Stack(
          children: [
            // 🔹 Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 8, 8, 9),
                    Color.fromARGB(255, 203, 20, 151),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // 🔸 Foreground content
            LayoutBuilder(
              builder: (context, constraints) {
                final contentPadding = isLandscape ? size.width * 0.15 : 16.0;

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    contentPadding,
                    16, // Removed kToolbarHeight since SafeArea handles top padding
                    contentPadding,
                    32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "DailyWellness",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 111, 94, 94),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Welcome, $userName 👋",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Current Time: $currentTime",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 16),

                      /// Quote Card
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(26, 17, 17, 17),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quote,
                              style: const TextStyle(
                                fontFamily: 'Caveat',
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "- $author",
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Task header
                      Text(
                        todayTask,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      /// Task List
                      if (taskProvider.tasks.isNotEmpty)
                        ListView.builder(
                          itemCount: taskProvider.tasks.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final task = taskProvider.tasks[index];
                            return Card(
                              color: Colors.white10,
                              child: ListTile(
                                title: Text(
                                  task,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        )
                      else
                        const Text(
                          "No tasks added yet!",
                          style: TextStyle(color: Colors.white60),
                        ),
                      const SizedBox(height: 24),

                      /// Add Activity button
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: _navigateToAddActivity,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              75,
                              20,
                              50,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: Text(
                            addActivity,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
