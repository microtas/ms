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
      backgroundColor: Colors.grey[100], // Softer background color
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
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder( // Use GridView.builder for better performance
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.2, // Adjust aspect ratio for better button shape
                ),
                itemCount: _menuItems.length, // List of menu items
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


  final List<_MenuItem> _menuItems = [ // Define menu items as a list
    _MenuItem(Icons.task, 'Ordres de travail', TaskOrderPage()),
    _MenuItem(Icons.assignment, 'Tâches', TaskPage()),
    _MenuItem(Icons.calendar_today, 'Planning', const Planning()),
    _MenuItem(Icons.receipt_long, 'Interventions', FicheInterventionListPage(interventions: [])),
    _MenuItem(Icons.person, 'Profil', ProfilPageTech()),
  ];

  Widget _buildMenuButton(BuildContext context, _MenuItem menuItem) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => menuItem.page));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(15), // Smaller padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.black26,
        elevation: 5, // Reduced elevation
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(menuItem.icon, size: 50, color: Colors.amber[400]), // Larger icon
          const SizedBox(height: 8), // Smaller spacing
          Text(menuItem.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, // Slightly smaller font size
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[900])),
        ],
      ),
    );
  }
}

class _MenuItem { // Helper class for menu items
  final IconData icon;
  final String label;
  final Widget page;

  _MenuItem(this.icon, this.label, this.page);
}