import 'package:flutter/material.dart';
import 'package:ms_maintain/API/HttpRequest.dart';
import 'package:ms_maintain/API/classes.dart';
import 'package:ms_maintain/API/paresXML.dart';
import 'package:ms_maintain/API/user.dart';
import 'package:ms_maintain/Client/RECLAMATION/detailsreclamation.dart';
import 'package:ms_maintain/Client/RECLAMATION/reclamation.dart';

class ListeReclamation extends StatefulWidget {
  final Function(Reclamation) onReclamationAdded;

  ListeReclamation({required this.onReclamationAdded, required List<Reclamation> reclamations});

  @override
  _ListeReclamationState createState() => _ListeReclamationState();
}

class _ListeReclamationState extends State<ListeReclamation> {
  List<Reclamation> reclamations = [];
  bool isLoading = true; // Variable pour gérer l'état de chargement
  final String codeclient = CurrentUser.loggedInClient!.CodeClient;

  @override
  void initState() {
    super.initState();
    fetchReclamation();  // Charge les réclamations au démarrage
  }

  void _deleteReclamation(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: const Text('Êtes-vous sûr de vouloir supprimer cette réclamation ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  reclamations.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Réclamation supprimée")),
                );
              },
              child: const Text('Oui'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Non'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchReclamation() async {
    
    setState(() {
      isLoading = true;  // Affiche le cercle de chargement avant la récupération des données
    });

    try {
      final response = await THttpHelper.get<Reclamation>(
        'GetLstRecl',
        parseReclamation,
        queryParameters: {'codeclient': codeclient},
      );
      setState(() {
        reclamations = response;
        isLoading = false;  // Masque le cercle de chargement une fois les données récupérées
      });
    } catch (e) {
      setState(() {
        isLoading = false;  // Masque le cercle de chargement en cas d'erreur
      });
      print("Erreur lors de l'appel de l'API : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de la récupération des réclamations")),
      );
    }
  }

  String _getEtatText(int Etat) {
    switch (Etat) {
      case 0: return "Demande soumise";
      case 1: return "En cours de traitement";
      case 2: return "Terminé";
      default: return "État inconnu";
    }
  }

  @override
  Widget build(BuildContext context) {
    return  isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset(
                'assets/logo.png', // Affiche le gif de chargement
                width: 400,
                height: 200,
              ),
            ),
          )
        :Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("Liste des Réclamations", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage du cercle de progression si isLoading est true
           
              Expanded(
                child: reclamations.isEmpty
                    ? Center(
                        child: Text(
                          "Aucune réclamation disponible.",
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      )
                    : ListView.builder(
                        itemCount: reclamations.length,
                        itemBuilder: (context, index) {
                          Reclamation reclamation = reclamations[index];
                          return Card(
                            color: reclamation.Etat == 1 ? Colors.yellow[100] : Colors.white,  // Couleur basée sur l'état
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
                               reclamation.NomSte,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[900]),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reclamation.NumRcl,
                                    style: const TextStyle(color: Colors.black87),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _getEtatText(reclamation.Etat),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue[900]),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (reclamation.Etat == 0)
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
