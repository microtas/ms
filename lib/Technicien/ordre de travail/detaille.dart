import 'package:flutter/material.dart';

class TaskDetailPage extends StatefulWidget {
  final Map<String, String> task;

  TaskDetailPage({required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task['designation']!,style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Title
              Text(
                'Demande de client No: ${widget.task['client_request_no']}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 15),
              Divider(color: Colors.teal[300]),

              _buildSection('Responsable:', widget.task['responsable']!),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: _buildDateInfo('Date début', widget.task['start_date']!)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildDateInfo('Date fin', widget.task['end_date']!)),
                ],
              ),
              const SizedBox(height: 15),

              // Times
              Row(
                children: [
                  Expanded(child: _buildTimeInfo('Heure début', widget.task['start_time']!)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTimeInfo('Heure fin', widget.task['end_time']!)),
                ],
              ),
              const SizedBox(height: 20),

              // Work Details
              _buildSection('Détails du travail:', widget.task['details']!),
              const SizedBox(height: 20),

              // Additional Information
              _buildSection('Informations complémentaires:', widget.task['additional_info']!),
              const SizedBox(height: 20),

              // Equipment Used
              _buildEquipmentSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for displaying sections with title and content
  Widget _buildSection(String title, String content) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 5),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the equipment section
  Widget _buildEquipmentSection() {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Équipements utilisés:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 10),
            _buildEquipInfo('Nom', widget.task['equipment_name']!),
            _buildEquipInfo('Matricule', widget.task['equipment_id']!),
          ],
        ),
      ),
    );
  }

  // Widget for date and time information with style
  Widget _buildDateInfo(String label, String value) {
    return _buildInfoCard(label, value);
  }

  Widget _buildTimeInfo(String label, String value) {
    return _buildInfoCard(label, value);
  }

  // Common widget for displaying information in a styled container
  Widget _buildInfoCard(String label, String value) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(fontSize: 16, color: Colors.teal)),
          ],
        ),
      ),
    );
  }

  // Widget for displaying equipment information
  Widget _buildEquipInfo(String label, String value) {
    return Padding(
      
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}