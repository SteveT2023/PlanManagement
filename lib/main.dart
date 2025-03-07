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
final List<Map<String, dynamic>> plans = [
    {'name': 'Plan 1', 'completed': false},
    {'name': 'Plan 2', 'completed': true},
  ];

  void _addPlan(String planName) {
    setState((){
      plans.add({'name': planName, 'completed': false});
    });
  }

  void _deletePlan(int index){
    setState((){
      plans.removeAt(index);
    });
  }

  void _updatePlan(int index, bool completed) {
    setState((){
      plans[index]['completed'] = completed;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}