import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Map<String, dynamic>> tasks = [
    {
      'id': 1,
      'description': 'Maintenance du moteur',
      'isAccepted': false,
      'isCompleted': false,
    },
    {
      'id': 2,
      'description': 'Changement de pneu',
      'isAccepted': false,
      'isCompleted': false,
    },
    {
      'id': 3,
      'description': 'Révision des freins',
      'isAccepted': false,
      'isCompleted': false,
    },
  ];

  void _acceptTask(int taskId) {
    setState(() {
      final task = tasks.firstWhere((task) => task['id'] == taskId);
      task['isAccepted'] = true;
    });
  }

  void _completeTask(int taskId) {
    setState(() {
      final task = tasks.firstWhere((task) => task['id'] == taskId);
      task['isCompleted'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Tâches', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 10,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 12),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.build, color: Colors.blue[900], size: 36),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            'Tâche ${task['id']} : ${task['description']}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    if (!task['isAccepted'] && !task['isCompleted'])
                      ElevatedButton(
                        onPressed: () => _acceptTask(task['id']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Accepter', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    if (task['isAccepted'] && !task['isCompleted'])
                      ElevatedButton(
                        onPressed: () => _completeTask(task['id']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Terminer', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    if (task['isCompleted'])
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[600], size: 30),
                          const SizedBox(width: 10),
                          Text(
                            'Tâche terminée',
                            style: TextStyle(fontSize: 16, color: Colors.green[600]),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logic to add new task
        },
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add,color: Colors.white),
      ),
    );
  }
}