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
        title: Text(widget.task['designation']!,style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
        backgroundColor: Colors.blue[900], // Couleur bleu foncé
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[50], // Fond clair pour contraster avec le bleu
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Title
              Text(
                'Demande de client No: ${widget.task['client_request_no']}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Bleu foncé pour la cohérence
                ),
              ),
              const SizedBox(height: 15),
              Divider(color: Colors.blue[300]), // Légère couleur bleue

              _buildSection('Responsable:', widget.task['responsable']!, icon: Icons.person),
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
              _buildSection('Détails du travail:', widget.task['details']!, icon: Icons.description),
              const SizedBox(height: 20),

              // Additional Information
              _buildSection('Informations complémentaires:', widget.task['additional_info']!, icon: Icons.info),
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
  Widget _buildSection(String title, String content, {IconData? icon}) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.amber[400], size: 28), // Bleu foncé pour l'icône
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Bleu foncé pour le titre
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Équipements utilisés:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
    return _buildInfoCard(label, value, icon: Icons.calendar_today);
  }

  Widget _buildTimeInfo(String label, String value) {
    return _buildInfoCard(label, value, icon: Icons.access_time);
  }

  // Common widget for displaying information in a styled container
  Widget _buildInfoCard(String label, String value, {IconData? icon}) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.amber[400], size: 24), // Utilisation du bleu foncé pour l'icône
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]), // Bleu foncé pour la valeur
                ),
              ],
            ),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), // Bleu foncé pour les labels
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
