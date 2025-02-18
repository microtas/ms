import 'package:flutter/material.dart';
import 'package:ms_maintain/Client/RECLAMATION/detailsreclamation.dart';
import 'package:ms_maintain/Client/RECLAMATION/reclamation.dart';
import 'package:ms_maintain/classes.dart';

class ListeReclamation extends StatefulWidget {
  final List<Reclamation> reclamations;
  final Function(Reclamation) onReclamationAdded;

  ListeReclamation({required this.reclamations, required this.onReclamationAdded});

  @override
  _ListeReclamationState createState() => _ListeReclamationState();
}

class _ListeReclamationState extends State<ListeReclamation> {
  void _deleteReclamation(int index) {
    setState(() {
      widget.reclamations.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Réclamation supprimée")),
    );
  }

  String _getEtatText(int etat) {
    switch (etat) {
      case 0: return "Demande soumise";
      case 1: return "En cours de traitement";
      default: return "État inconnu";
    }
  }

  int _countEnCours() {
    return widget.reclamations.where((r) => r.etat == 1).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Center(child: Text("Réclamations", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white))),
        backgroundColor: Colors.blue[900],
       /* actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                "En cours: ${_countEnCours()}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
     */
     
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: widget.reclamations.isEmpty
                  ? Center(
                      child: Text(
                        "Aucune réclamation disponible.",
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.reclamations.length,
                      itemBuilder: (context, index) {
                        Reclamation reclamation = widget.reclamations[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[900],
                              child: const Icon(Icons.business, color: Colors.white),
                            ),
                            title: Text(
                              reclamation.societe,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[900]),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reclamation.remarque,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _getEtatText(reclamation.etat),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue[900]),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (reclamation.etat == 0)
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteReclamation(index),
                                  ),
                               Icon(Icons.arrow_forward_ios, color: Colors.blue[900]),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReclamationDetailPage(reclamation: reclamation),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReclamationPage(
                        onReclamationAdded: widget.onReclamationAdded,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600],
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 5,
                ),
                child: const Text(
                  "Ajouter une Réclamation",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
