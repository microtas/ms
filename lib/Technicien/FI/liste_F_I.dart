import 'package:flutter/material.dart';
import 'package:ms_maintain/Technicien/FI/F_I.dart';

class FicheInterventionListPage extends StatefulWidget {
  final List<Map<String, String>> interventions;

  FicheInterventionListPage({required this.interventions});

  @override
  _FicheInterventionListPageState createState() => _FicheInterventionListPageState();
}

class _FicheInterventionListPageState extends State<FicheInterventionListPage> {
  // Méthode pour ajouter une nouvelle intervention à la liste
  void _addIntervention(Map<String, String> newIntervention) {
    setState(() {
      widget.interventions.add(newIntervention);
    });
  }

  void _deleteIntervention(int index) {
    setState(() {
      widget.interventions.removeAt(index); // Supprime l'élément à l'index donné
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Liste des Fiches d\'Intervention', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: widget.interventions.isEmpty
                  ? const Center(
                      child: Text(
                        'Aucune intervention disponible.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.interventions.length,
                      itemBuilder: (context, index) {
                        final intervention = widget.interventions[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  child: Icon(Icons.work, color: Colors.white),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tâche: ${intervention['taskDescription']}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal[800],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Équipements: ${intervention['equipments']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.teal[600],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Date: ${intervention['date'] ?? 'Non spécifiée'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Icône pour supprimer l'intervention
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteIntervention(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newIntervention = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (context) => InterventionFormPage()),
          );

          if (newIntervention != null) {
            _addIntervention(newIntervention);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
