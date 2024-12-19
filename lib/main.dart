import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/home_page.dart';
import 'package:todo_provider/providers/todo_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
