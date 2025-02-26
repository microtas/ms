import 'package:flutter/material.dart';
import 'package:ms_maintain/API/HttpRequest.dart';
import 'package:ms_maintain/API/classes.dart';
import 'package:ms_maintain/API/paresXML.dart';
import 'package:ms_maintain/API/user.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final String MFClient =  CurrentUser.loggedInClient!.MF;
    final String PassClient =  CurrentUser.loggedInClient!.Pass;


  Future<Client> fetchClient() async {
    try {
      final response = await THttpHelper.get<Client>(
        'GetCLient',
        parseClient,
        queryParameters: {
          'Login':MFClient,
          'Pass':PassClient,
        },
      );
      if (response.isNotEmpty) {
        return response.first; // Supposant que l'API renvoie une liste
      } else {
        throw Exception("Aucune donnée disponible.");
      }
    } catch (e) {
      throw Exception("Erreur lors de l'appel de l'API : $e");
    }
  }

  void _logout() {
    setState(() {
      CurrentUser.loggedInClient = null; // Supprime l'utilisateur connecté
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Client>(
      future: fetchClient(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset(
                'assets/logo.png',
                width: 400,
                height: 200,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                'Erreur: ${snapshot.error}',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                "Aucune donnée disponible.",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          );
        } else {
          final client = snapshot.data!;

          return Scaffold(
            backgroundColor: Colors.white70,
            appBar: AppBar(
              title: Text(
                "Mon Profil",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue[900],
              iconTheme: IconThemeData(color:Colors.blue[900] ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Photo de profil
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/logo.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Carte contenant toutes les informations du client
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildListTile(Icons.person, "Nom", client.Raison ?? "N/A"),
                            _buildListTile(Icons.email, "Email", client.Email ?? "N/A"),
                            _buildListTile(Icons.phone, "Téléphone", client.Tel1 ?? "N/A"),
                            _buildListTile(Icons.home, "Adresse", client.Adresse ?? "N/A"),
                            _buildListTile(Icons.location_city, "Gouvernorat", client.Gouvernorat ?? "N/A"),
                            _buildListTile(Icons.flag, "Pays", client.Pays ?? "N/A"),
                            _buildListTile(Icons.business, "Banque", client.Banque?.toString() ?? "N/A"),
                            _buildListTile(Icons.account_balance, "Compte Bancaire", client.CompteBq ?? "N/A"),
                            _buildListTile(Icons.payment, "Mode de Paiement", client.ModPai ?? "N/A"),
                            _buildListTile(Icons.monetization_on, "Encours", client.Encours?.toString() ?? "N/A"),
                            _buildListTile(Icons.timelapse, "Date Début Exonération", client.DebExo?.toLocal().toString().split(' ')[0] ?? "N/A"),
                            _buildListTile(Icons.timelapse, "Date Fin Exonération", client.FinExo?.toLocal().toString().split(' ')[0] ?? "N/A"),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Bouton de déconnexion
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[600],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _logout,
                        child: const Text("Se déconnecter", style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  // Fonction utilitaire pour créer des ListTile
  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.amber[600]),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
        ),
        const Divider(),
      ],
    );
  }
}
