import 'dart:async';
import 'package:daily_wellness/core/constants/constant.dart';
import 'package:daily_wellness/core/utils/time_formatter.dart';
import 'package:daily_wellness/core/widgets/add_activity_button.dart';
import 'package:daily_wellness/core/widgets/add_activity_screen.dart';
import 'package:daily_wellness/core/widgets/dashboard_header.dart';
import 'package:daily_wellness/core/widgets/quote_card_widget.dart';
import 'package:daily_wellness/core/widgets/task_list.dart';
import 'package:daily_wellness/providers/task_provider.dart';
import 'package:daily_wellness/services/api/quote_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "Pooja";
  String currentTime = "";
  String quote = "";
  String author = "";
  bool isLoading = true;

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
      currentTime = formatCurrentTime(now);
    });
  }

  Future<void> _fetchQuote() async {
    setState(() {
      isLoading = true;
    });

    final result = await QuoteService.fetchQuoteOfTheDay();
    setState(() {
      quote = result['quote']!;
      author = result['author']!;
      isLoading = false;
    });
  }

  void _navigateToAddActivity() async {
  final result = await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: addActivity,
    barrierColor: Colors.black.withOpacity(0.22),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const AddActivityScreen();
    },
  );

  if (result != null) {
    final data = result as Map<String, dynamic>;
    final activity = data['activity'];
    final notes = data['notes'];

    if (activity != null) {
      Provider.of<TaskProvider>(context, listen: false).addTasks(activity, notes);
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
        child: Stack(
          children: [
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
            LayoutBuilder(
              builder: (context, constraints) {
                final contentPadding = isLandscape ? size.width * 0.15 : 16.0;
                
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    contentPadding,
                    16,
                    contentPadding,
                    32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      DashboardHeader(
                        userName: userName,
                        currentTime: currentTime,
                        isLoading: isLoading,
                        quoteCard: const QuoteCardWidget(),
                      ),

                      // Quote Card with loader
                      const SizedBox(height: 24),
                      Text(
                        todayTask,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const TaskList(),
                      const SizedBox(height: 24),
                      AddActivityButton(onPressed: _navigateToAddActivity),
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
