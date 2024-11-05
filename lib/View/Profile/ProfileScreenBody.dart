import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import '../../Providers/todoprovider.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  _ProfileScreenBodyState createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  File? _profileImage;
  final String _profileImageKey = 'profileImagePath';
  final String _quoteKey = 'userQuote'; // Key for shared preferences
  String _quote = "Tap to edit your quote"; // Default quote
  bool _isEditing = false; // Flag to check if in edit mode

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadQuote(); // Load the quote from shared preferences
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _saveProfileImage(pickedFile.path);
    }
  }

  Future<void> _saveProfileImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_profileImageKey);
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _loadQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final quote = prefs.getString(_quoteKey) ?? "Tap to edit your quote";
    setState(() {
      _quote = quote;
    });
  }

  Future<void> _saveQuote(String quote) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_quoteKey, quote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          final completedTasks = todoProvider.completedTaskCount;
          final pendingTasks = todoProvider.pendingTaskCount;
          final totalTasks = completedTasks + pendingTasks;

          return LayoutBuilder(
            builder: (context, constraints) {
              final isPortrait = constraints.maxWidth < constraints.maxHeight;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: isPortrait ? 50 : 30,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : AssetImage('assets/placeholder.png') as ImageProvider,
                          child: _profileImage == null
                              ? Icon(Icons.camera_alt, size: 24, color: Colors.white)
                              : null,
                        ),
                      ),
                      SizedBox(height: 20), // Space between profile picture and quote

                      // Editable Quote
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEditing = true; // Enable editing mode
                          });
                        },
                        child: _isEditing
                            ? TextField(
                          autofocus: true,
                          onSubmitted: (value) {
                            setState(() {
                              _quote = value; // Update the quote
                              _isEditing = false; // Exit editing mode
                            });
                            _saveQuote(value); // Save the quote to shared preferences
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your quote',
                            border: InputBorder.none, // No border
                            contentPadding: EdgeInsets.all(8),
                          ),
                          style: GoogleFonts.dancingScript(), // Apply Dancing Script font
                        )
                            : Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            _quote,
                            style: GoogleFonts.dancingScript(fontSize: 16, color: Colors.black), // Apply Dancing Script font
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Space between quote and pie chart

                      // Pie Chart
                      SizedBox(
                        height: constraints.maxWidth * 0.7,
                        child: totalTasks > 0
                            ? PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: completedTasks.toDouble(),
                                color: Colors.purple,
                                title: '',
                              ),
                              PieChartSectionData(
                                value: pendingTasks.toDouble(),
                                color: Colors.purpleAccent,
                                title: '',
                              ),
                            ],
                            sectionsSpace: 7,
                            centerSpaceRadius: 80,
                            borderData: FlBorderData(show: false),
                          ),
                        )
                            : Center(
                          child: Text(
                            'No task data available.',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Space between pie chart and task counts

                      // Task Counts
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: Colors.purple,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Completed Tasks: $completedTasks',
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: Colors.purpleAccent,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Pending Tasks: $pendingTasks',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
