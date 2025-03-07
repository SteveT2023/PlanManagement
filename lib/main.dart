import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: planManagerScreen(),
    );
  }
}

class planManagerScreen extends StatefulWidget {
  const planManagerScreen({super.key});

  @override
  State<planManagerScreen> createState() => _planManagerScreenState();
}

class _planManagerScreenState extends State<planManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}