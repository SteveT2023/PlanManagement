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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void _addPlan(String planName, String description, String date) {
    setState(() {
      plans.add({
        'name': planName,
        'description': description,
        'date': date,
        'completed': false,
        'editingName': false
      });
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

  Future<void> _planDescription() async {
    _nameController.clear();
    _descriptionController.clear();
    _dateController.clear();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text ('Enter Plan Details'),
          content: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Plan Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Plan Description'),
              ),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Plan Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addPlan(_nameController.text, _descriptionController.text, _dateController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Manager', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: DragTarget<Map<String, dynamic>>(
              onAccept: (dragPlan) {
                _addPlan(dragPlan['name'], dragPlan['description'], dragPlan['date']);
              },
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
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
                              _nameController.text = plans[index]['name'];
                            });
                          },
                          onDoubleTap: () {
                            _deletePlan(index);
                          },
                          child: plans[index]['editingName']
                              ? TextField(
                                  controller: _nameController,
                                  onSubmitted: (newName) {
                                    _editName(index, newName);
                                  },
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plans[index]['name'],
                                      style: TextStyle(
                                        color: plans[index]['completed'] ? Colors.green : Colors.orange,
                                      ),
                                    ),
                                    Text(plans[index]['description']),
                                    Text(plans[index]['date']),
                                  ],
                                ),
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
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Draggable<Map<String, dynamic>>(
            data: {'name': 'New Plan', 'description': '', 'date': ''},
            feedback: Material(
              child: FloatingActionButton.extended(
                onPressed: null,
                backgroundColor: Colors.deepOrangeAccent,
                label: const Text("New Plan"),
              ),
            ),
            child: FloatingActionButton.extended(
              onPressed: null,
              label: const Text("Drag to Create Plan"),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              _planDescription();
            },
            label: const Text("Create Plan"),
          ),
        ],
      ),
    );
  }
}