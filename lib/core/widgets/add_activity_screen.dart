import 'dart:ui';
import 'package:daily_wellness/core/constants/constant.dart';
import 'package:flutter/material.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _activityController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _activityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveActivity() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'activity': _activityController.text,
        'notes': _notesController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Material(
      color: const Color.fromARGB(255, 12, 12, 12).withOpacity(0.8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          return Center(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      width: isLandscape ? maxWidth * 0.6 : maxWidth * 0.9,
                      padding: EdgeInsets.symmetric(
                        horizontal: isLandscape ? 32 : 24,
                        vertical: isLandscape ? 32 : 24,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 238, 238),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 12),
                              Text(
                                addNewActivity,
                                style: TextStyle(
                                  fontSize: isLandscape ? 26 : 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 9, 8, 8),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: _activityController,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: activityName,
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 200, 36, 131),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return requireName;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _notesController,
                                maxLines: isLandscape ? 4 : 3,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: notesOptional,
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.05),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 200, 36, 131),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: _saveActivity,
                                icon: const Icon(Icons.save),
                                label: Text(save),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    133,
                                    9,
                                    54,
                                  ),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 28,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 6,
                                  shadowColor: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 10,
                  top: 10,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: Colors.black, size: 20),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
