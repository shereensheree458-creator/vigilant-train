import 'package:flutter/material.dart';

void main() {
  runApp(const SmartCompanionApp());
}

class SmartCompanionApp extends StatelessWidget {
  const SmartCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الرفيق الذكي',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرفيق الذكي'),
      ),
      body: const Center(
        child: Text(
          'أهلاً بك في تطبيق الرفيق الذكي',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

