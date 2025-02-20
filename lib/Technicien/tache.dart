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
      'isRejected': false,
      'isPending': false,
      'pendingReason': '',
    },
    {
      'id': 2,
      'description': 'Changement de pneu',
      'isAccepted': false,
      'isCompleted': false,
      'isRejected': false,
      'isPending': false,
      'pendingReason': '',
    },
    {
      'id': 3,
      'description': 'Révision des freins',
      'isAccepted': false,
      'isCompleted': false,
      'isRejected': false,
      'isPending': false,
      'pendingReason': '',
    },
  ];

  void _acceptTask(int taskId) {
    setState(() {
      final task = tasks.firstWhere((task) => task['id'] == taskId);
      task['isAccepted'] = true;
      task['isRejected'] = false;
      task['isPending'] = false;
    });
  }

  void _completeTask(int taskId) {
    setState(() {
      final task = tasks.firstWhere((task) => task['id'] == taskId);
      task['isCompleted'] = true;
    });
  }

  void _putOnHoldTask(int taskId) async {
    final TextEditingController reasonController = TextEditingController();
    String reason = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Indiquer la raison de la mise en attente"),
          content: TextField(
            controller: reasonController,
            decoration: InputDecoration(hintText: "Entrez la raison ici"),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                reason = reasonController.text;
                Navigator.of(context).pop();
              },
              child: Text('Confirmer'),
            ),
          ],
        );
      },
    );

    if (reason.isNotEmpty) {
      setState(() {
        final task = tasks.firstWhere((task) => task['id'] == taskId);
        task['isPending'] = true;
        task['pendingReason'] = reason;
        task['isAccepted'] = false;
        task['isRejected'] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Gestion des Tâches',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.build_outlined, color: Colors.blue[900], size: 40),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            'Tâche ${task['id']} : ${task['description']}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    if (!task['isAccepted'] && !task['isCompleted'] && !task['isRejected'] && !task['isPending']) ...[
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _acceptTask(task['id']),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[700],
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                elevation: 5,
                              ),
                              icon: Icon(Icons.check_circle_outline, color: Colors.white),
                              label: Text('Accepter', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _putOnHoldTask(task['id']),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[700],
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                elevation: 5,
                              ),
                              icon: Icon(Icons.hourglass_empty, color: Colors.white),
                              label: Text('Mettre en attente', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (task['isAccepted'] && !task['isCompleted'])
                      ElevatedButton.icon(
                        onPressed: () => _completeTask(task['id']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                        ),
                        icon: Icon(Icons.done_all, color: Colors.white),
                        label: Text('Terminer', style: TextStyle(color: Colors.white)),
                      ),
                    if (task['isCompleted'])
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[600], size: 30),
                          SizedBox(width: 10),
                          Text(
                            'Tâche terminée',
                            style: TextStyle(fontSize: 16, color: Colors.green[600]),
                          ),
                        ],
                      ),
                    if (task['isRejected'])
                      Row(
                        children: [
                          Icon(Icons.cancel, color: Colors.red[700], size: 30),
                          SizedBox(width: 10),
                          Text(
                            'Tâche refusée',
                            style: TextStyle(fontSize: 16, color: Colors.red[700]),
                          ),
                        ],
                      ),
                    if (task['isPending'])
                      Row(
                        children: [
                          Icon(Icons.hourglass_empty, color: Colors.orange[700], size: 30),
                          SizedBox(width: 10),
                          Text(
                            'En attente: ${task['pendingReason']}',
                            style: TextStyle(fontSize: 16, color: Colors.orange[700]),
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
    );
  }
}
