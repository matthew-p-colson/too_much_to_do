import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:too_much_to_do/models/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox('taskBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade800,
          leading: const Icon(
            Icons.rule,
            color: Colors.white,
            size: 40.0,
          ),
          title: const Text(
            'Too Much To Do',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'ShadowsIntoLight',
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
