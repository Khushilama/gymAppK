import 'package:flutter/material.dart';

void main() {
  runApp(GymApp());
}

class GymApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App Achievements',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AchievementsScreen(),
    );
  }
}

class AchievementsScreen extends StatelessWidget {
  // Sample list of user achievements
  final List<String> achievements = [
    'Completed 30-Day Challenge',
    'Reached 100 Workouts',
    'Lifted Personal Best Weight',
    'Consistent Weekly Routine',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.star), // You can use appropriate icons here
            title: Text(achievements[index]),
          );
        },
      ),
    );
  }
}
