import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TacheDetailPage extends StatelessWidget {
  final Map<String, dynamic> task;

  const TacheDetailPage({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Détails de la Tâche",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
       backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              icon: Icons.build,
              title: "Tâche",
              content: task['description'] ?? 'Non spécifiée',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.check_circle,
              title: "Statut",
              content: task['isAccepted']
                  ? (task['isCompleted'] ? 'Terminée' : 'Acceptée')
                  : 'Non acceptée',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.calendar_today,
              title: "Date d'acceptation",
              content: task['acceptanceDate'] ?? 'Non spécifiée',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.timer,
              title: "Heure de début",
              content: task['startTime'] ?? 'Non spécifiée',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.description,
              title: "Description complète",
              content: task['fullDescription'] ?? 'Aucune description',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required dynamic content,
    required Color iconColor,
    required Color contentColor,
  }) {
    String displayContent;

    // Si le contenu est de type DateTime, formatons-le correctement
    if (content is DateTime) {
      displayContent = DateFormat('dd/MM/yyyy').format(content);  
    } else {
      displayContent = content.toString();
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  displayContent, 
                  style: TextStyle(
                    fontSize: 16,
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
