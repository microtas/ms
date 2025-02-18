import 'package:flutter/material.dart';
import 'package:ms_maintain/Technicien/ordre%20de%20travail/detaille.dart';

class TaskOrderPage extends StatefulWidget {
  @override
  State<TaskOrderPage> createState() => _TaskOrderPageState();
}

class _TaskOrderPageState extends State<TaskOrderPage> {
  final List<Map<String, String>> tasks = [
    {
      'designation': 'Réparation moteur',
      'date': '17/02/2025',
      'details': 'Remplacement des pièces endommagées et réglage moteur.',
      'client_request_no': '12345',
      'responsable': 'Technicien A',
      'start_date': '17/02/2025',
      'end_date': '17/02/2025',
      'start_time': '08:00',
      'end_time': '12:00',
      'additional_info': 'Aucun',
      'equipment_name': 'Clé à molette',
      'equipment_id': 'QWERTY123'
    },
    {
      'designation': 'Changement batterie',
      'date': '18/02/2025',
      'details': 'Remplacement de la batterie et vérification du circuit électrique.',
      'client_request_no': '67890',
      'responsable': 'Technicien B',
      'start_date': '18/02/2025',
      'end_date': '18/02/2025',
      'start_time': '10:00',
      'end_time': '13:00',
      'additional_info': 'Vérifier l’alternateur après remplacement.',
      'equipment_name': 'Multimètre',
      'equipment_id': 'ZXCVB456'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordre de Tâche',style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),

      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.build, color: Colors.teal, size: 40),
              title: Text(
                tasks[index]['designation']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.teal[800],
                ),
              ),
              subtitle: Text(
                'Date: ${tasks[index]['date']}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailPage(task: tasks[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}