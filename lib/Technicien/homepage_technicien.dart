import 'package:flutter/material.dart';
import 'package:ms_maintain/Technicien/FI/liste_F_I.dart';
import 'package:ms_maintain/Technicien/Plannig.dart';
import 'package:ms_maintain/Technicien/ordre%20de%20travail/ordretache.dart';
import 'package:ms_maintain/Technicien/profiltech.dart';
import 'package:ms_maintain/Technicien/tache.dart';

class HomePageTechnicien extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Accueil Technicien',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenue !',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  return _buildMenuButton(context, _menuItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<_MenuItem> _menuItems = [
    _MenuItem('assets/ordre.png', 'Ordres de travail', TaskOrderPage()),
    _MenuItem('assets/ordre.png', 'Tâches', TaskPage()),
    _MenuItem('assets/ordre.png', 'Planning', const Planning()),
    _MenuItem('assets/ordre.png', 'Interventions', FicheInterventionListPage(interventions: [])),
    _MenuItem('assets/ordre.png', 'Profil', ProfilPageTech()),
  ];

  Widget _buildMenuButton(BuildContext context, _MenuItem menuItem) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => menuItem.page));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.blue[900],
        elevation: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(menuItem.iconPath, height: 80, fit: BoxFit.contain),
          const SizedBox(height: 10),
          Text(menuItem.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900])),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String iconPath;
  final String label;
  final Widget page;

  _MenuItem(this.iconPath, this.label, this.page);
}
