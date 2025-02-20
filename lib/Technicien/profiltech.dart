import 'package:flutter/material.dart';

class ProfilPageTech extends StatefulWidget {
  @override
  _ProfilPageTechState createState() => _ProfilPageTechState();
}

class _ProfilPageTechState extends State<ProfilPageTech> {
  String nom = "Foulen";
  String email = "Foulen@example.com";
  String telephone = "+213 555 123 456";

  void _seDeconnecter() {
    //Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text("Mon Profil", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white))),
        backgroundColor: Colors.blue[900],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/logo.png'), 
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading:  Icon(Icons.person, color: Colors.amber[600]),
                        title: Text(nom, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      const Divider(),
                      ListTile(
                        leading:  Icon(Icons.email, color: Colors.amber[600]),
                        title: Text(email, style: const TextStyle(fontSize: 16)),
                      ),
                      const Divider(),
                      ListTile(
                        leading:  Icon(Icons.phone, color: Colors.amber[600]),
                        title: Text(telephone, style: const TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _seDeconnecter,
                  child: const Text("Se déconnecter", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
