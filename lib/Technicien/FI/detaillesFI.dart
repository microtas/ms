import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InterventionDetailsPage extends StatelessWidget {
  final Map<String, String> intervention;

  const InterventionDetailsPage({required this.intervention, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Détails de l'Intervention",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[900]!, Colors.blue[700]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              icon: Icons.work,
              title: "Tâche",
              content: intervention['taskDescription'] ?? 'Non spécifiée',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.calendar_today,
              title: "Date",
              content: intervention['date'] ?? 'Non spécifiée',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.access_time,
              title: "Heure",
              content: intervention['time'] ?? 'Non spécifiée',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.confirmation_number,
              title: "Numéro de l'Intervention",
              content: intervention['id'] ?? 'Non spécifié',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.comment,
              title: "Remarque",
              content: intervention['remark'] ?? 'Aucune remarque',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.description,
              title: "Description",
              content: intervention['description'] ?? 'Aucune description',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 24, thickness: 1),
            _buildDetailRow(
              icon: Icons.visibility,
              title: "Observation des Équipements",
              content: intervention['equipmentObservations'] ?? 'Aucune observation',
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
