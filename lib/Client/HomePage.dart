import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ms_maintain/API/HttpRequest.dart';
import 'package:ms_maintain/API/classes.dart';
import 'package:ms_maintain/API/paresXML.dart';
import 'package:ms_maintain/API/user.dart';
import 'package:ms_maintain/Client/RECLAMATION/liste_reclamation.dart';
import 'package:ms_maintain/Client/profil.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Reclamation> reclamations = [];
  int _selectedIndex = 0;
  bool isLoading = true; 
  final codeclient =  CurrentUser.loggedInClient!.CodeClient;

  int _countEnCours() {
    return reclamations.where((r) => r.Etat == 1).length;
  }

Future<void> fetchReclamation() async {
    setState(() {
      isLoading = true;  
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
 int _countEquipements() {
  // Récupérer tous les équipements depuis les réclamations
  final equipementCounts = <int, int>{};

  // Compter les occurrences de chaque équipement
  for (var r in reclamations) {
    equipementCounts[r.eqp] = (equipementCounts[r.eqp] ?? 1) + 1;
  }

  // Compter uniquement les équipements qui apparaissent une seule fois
  return equipementCounts.values.where((count) => count == 1).length;
}


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
@override
void initState() {
    super.initState();
    fetchReclamation(); 
}

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Card for "Réclamations en cours"
              Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.warning, color: Colors.orange[700], size: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Réclamations en cours",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${_countEnCours()}",
                          
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.device_hub, color: Colors.green[700], size: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Équipements disponibles",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${_countEquipements()}",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[700]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ListeReclamation(reclamations: reclamations, onReclamationAdded: (Reclamation r) {
        setState(() {
          reclamations.add(r);
        });
      }),
      ProfilPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      body: _pages[_selectedIndex], // Affiche la page sélectionnée
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 13, 71, 161),
        height: 60,
        index: _selectedIndex,
        items:  <Widget>[
          Icon(Icons.home, size: 30,color: Colors.blue[900],),
          Icon(Icons.list,size: 30,color: Colors.blue[900],),
          Icon(Icons.person, size: 30,color: Colors.blue[900],),
        ],
       // currentIndex: _selectedIndex,
       // selectedItemColor: Colors.blue[900],
        onTap: _onItemTapped,
      ),
    );
  }
}
