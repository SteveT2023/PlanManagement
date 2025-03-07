import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlanManagerScreen(),
    );
  }
}

class PlanManagerScreen extends StatefulWidget {
  const PlanManagerScreen({super.key});

  @override
  State<PlanManagerScreen> createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
final List<Map<String, dynamic>> plans = [];

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
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Plan Manager', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder (
        itemCount: plans.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(plans[index]['name']),
            leading: Checkbox(
              value: plans[index]['completed'],
              onChanged: (value) {
                if (value != null) {
                  _updatePlan(index, value);
                }
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){
                _deletePlan(index);
              }
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPlan ('New Plan');
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}