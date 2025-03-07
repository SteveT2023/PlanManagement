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
  final TextEditingController _controller = TextEditingController();

  void _addPlan(String planName) {
    setState(() {
      plans.add({'name': planName, 'completed': false, 'editingName': false});
    });
  }

  void _deletePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  void _updatePlan(int index, bool completed) {
    setState(() {
      plans[index]['completed'] = completed;
    });
  }

  void _editName(int index, String newName) {
    setState(() {
      plans[index]['name'] = newName;
      plans[index]['editingName'] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Manager', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                plans[index]['completed'] = !plans[index]['completed'];
              });
            },
            child: ListTile(
              title: GestureDetector(
                onLongPress: () {
                  setState(() {
                    plans[index]['editingName'] = true;
                    _controller.text = plans[index]['name'];
                  });
                },
                onDoubleTap: (){
                  _deletePlan(index);
                },
                child: plans[index]['editingName']
                    ? TextField(
                        controller: _controller,
                        onSubmitted: (newName) {
                          _editName(index, newName);
                        },
                      )
                    : Text(plans[index]['name'], style: TextStyle(color: plans[index]['completed'] ? Colors.green : Colors.orange)),
              ),
              leading: Checkbox(
                value: plans[index]['completed'],
                onChanged: (value) {
                  if (value != null) {
                    _updatePlan(index, value);
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addPlan('New Plan');
        },
        label: const Text("Create Plan")
      ),
    );
  }
}