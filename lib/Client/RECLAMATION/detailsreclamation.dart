import 'package:flutter/material.dart';
import 'package:ms_maintain/classes.dart';

class ReclamationDetailPage extends StatelessWidget {
  final Reclamation reclamation;

  ReclamationDetailPage({required this.reclamation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Détails de la Réclamation",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
                iconTheme: IconThemeData(color: Colors.white),

        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[900]!, Colors.blue[700]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre principal
            Text(
              "Réclamation de ${reclamation.societe}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 20),

            // Section Remarque
            _buildDetailRow(
              icon: Icons.comment,
              title: "Remarque",
              content: reclamation.remarque,
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 30, thickness: 1),

            // Section Description
            _buildDetailRow(
              icon: Icons.description,
              title: "Description",
              content: reclamation.description,
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 30, thickness: 1),

            // Section Équipement
            _buildDetailRow(
              icon: Icons.device_hub,
              title: "Équipement",
              content: reclamation.equipement ?? 'Non spécifié',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 30, thickness: 1),

            // Section Panne
            _buildDetailRow(
              icon: Icons.error_outline,
              title: "Panne",
              content: reclamation.panne ?? 'Non spécifiée',
              iconColor: Colors.blue[900]!,
              contentColor: Colors.black87,
            ),
            const Divider(height: 30, thickness: 1),

            // Section État
            _buildDetailRow(
              icon: Icons.info_outline,
              title: "État",
              content: _getEtatText(reclamation.etat),
              iconColor: _getEtatColor(reclamation.etat),
              contentColor: _getEtatColor(reclamation.etat),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer une ligne de détail
  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String content,
    required Color iconColor,
    required Color contentColor,
  }) {
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
          // Icône
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          // Titre et contenu
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
                  content,
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

  // Fonction pour déterminer l'état de la réclamation
  String _getEtatText(int etat) {
    switch (etat) {
      case 0: return "Demande soumise";
      case 1: return "En cours de traitement";
      default: return "État inconnu";
    }
  }

  Color _getEtatColor(int etat) {
    switch (etat) {
      case 0: return Colors.red; // Rouge pour "Demande soumise"
      case 1: return Colors.orange; // Orange pour "En cours de traitement"
      default: return Colors.grey; // Gris pour "État inconnu"
    }
  }
}
