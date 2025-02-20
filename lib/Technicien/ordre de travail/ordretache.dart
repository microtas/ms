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
      backgroundColor:Colors.white ,
      appBar: AppBar(
        title: const Text('Ordre de Tâche',style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.grey[100],
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailPage(task: tasks[index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.build,
                      color: Colors.amber[600],
                      size: 40,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tasks[index]['designation']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Date: ${tasks[index]['date']}',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Responsable: ${tasks[index]['responsable']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue[900],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
