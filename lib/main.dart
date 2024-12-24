import 'package:flutter/material.dart';
import 'package:taskly/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';


  

void main() async {
  await Hive.initFlutter("hive_boxes");

   Hive.registerAdapter(TaskAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Master',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    home: HomePage(),
    );
  }
}
