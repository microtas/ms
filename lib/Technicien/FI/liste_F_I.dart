import 'package:flutter/material.dart';
import 'package:ms_maintain/Technicien/FI/F_I.dart';
import 'package:ms_maintain/Technicien/FI/detaillesFI.dart';

class FicheInterventionListPage extends StatefulWidget {
  final List<Map<String, String>> interventions;

  FicheInterventionListPage({required this.interventions});

  @override
  _FicheInterventionListPageState createState() =>
      _FicheInterventionListPageState();
}

class _FicheInterventionListPageState extends State<FicheInterventionListPage> {
  void _addIntervention(Map<String, String> newIntervention) {
    setState(() {
      widget.interventions.add(newIntervention);
    });
  }

  // Méthode pour modifier une intervention
  void _editIntervention(int index, Map<String, String> updatedIntervention) {
    setState(() {
      widget.interventions[index] = updatedIntervention;
    });
  }

  void _deleteIntervention(int index) {
    setState(() {
      widget.interventions
          .removeAt(index); 
    });
  }

  Color _getCardColor(String state) {
    switch (state) {
      case '0':
        return Colors.white;
      case '1':
        return Colors.grey[300] ?? Colors.grey;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Liste des Fiches d\'Intervention',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        backgroundColor: Colors.blue[900],
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
                        final state =
                            intervention['state'] ?? '0'; // Par défaut à 0

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InterventionDetailsPage(
                                    intervention: intervention),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            color: _getCardColor(state),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.amber[600],
                                    child: const Icon(Icons.work,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tâche: ${intervention['taskDescription']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Équipements: ${intervention['equipments']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
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
                                  if (state == '0')
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () async {
                                            // Modifier l'intervention
                                            final updatedIntervention =
                                                await Navigator.push<
                                                    Map<String, String>>(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InterventionFormPage(
                                                  existingIntervention:
                                                      intervention,
                                                ),
                                              ),
                                            );

                                            if (updatedIntervention != null) {
                                              _editIntervention(
                                                  index, updatedIntervention);
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () =>
                                              _deleteIntervention(index),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
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
        backgroundColor: Colors.amber[600],
      ),
    );
  }
}
