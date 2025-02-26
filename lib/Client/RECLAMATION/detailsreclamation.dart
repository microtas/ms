import 'package:flutter/material.dart';
import 'package:ms_maintain/API/HttpRequest.dart';
import 'package:ms_maintain/API/classes.dart';
import 'package:ms_maintain/API/paresXML.dart';
import 'package:intl/intl.dart';
import 'package:ms_maintain/API/user.dart';


class ReclamationDetailPage extends StatefulWidget {
  final Reclamation reclamation;

  ReclamationDetailPage({required this.reclamation});

  @override
  State<ReclamationDetailPage> createState() => _ReclamationDetailPageState();
}

class _ReclamationDetailPageState extends State<ReclamationDetailPage> {
  final String codeclient = CurrentUser.loggedInClient!.CodeClient;

  Future<Reclamation> fetchReclamation() async {
    try {
      final response = await THttpHelper.get<Reclamation>(
        'GetLstRecl',
        parseReclamation,
        queryParameters: {'codeclient': codeclient},
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Reclamation>(
      future: fetchReclamation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child:  Image.asset(
                'assets/logo.png', // Affiche le gif de chargement
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
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                "Aucune donnée disponible.",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          );
        } else {
          final reclamation = snapshot.data!;
          print(reclamation.HrEmi);
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
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[900]!, Colors.blue[700]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    icon: Icons.business,
                    title: "Nom de société",
                    content: reclamation.NomSte,
                    iconColor: Colors.blue[900]!,
                    contentColor: Colors.black87,
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildDetailRow(
                    icon: Icons.calendar_today,
                    title: "Date",
content: reclamation.Date,
                    
                    iconColor: Colors.blue[900]!,
                    contentColor: Colors.black87,
                  ),
                  
                  const Divider(height: 24, thickness: 1),
                  _buildDetailRow(
                    icon: Icons.access_time,
                    title: "Heure",
                    content: reclamation.HrEmi,
                    iconColor: Colors.blue[900]!,
                    contentColor: Colors.black87,
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildDetailRow(
                    icon: Icons.confirmation_number,
                    title: "Numéro de Réclamation",
                    content: reclamation.NumRcl,
                    iconColor: Colors.blue[900]!,
                    contentColor: Colors.black87,
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildDetailRow(
                    icon: Icons.comment,
                    title: "Remarque",
                    content: reclamation.Resume,
                    iconColor: Colors.blue[900]!,
                    contentColor: Colors.black87,
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildDetailRow(
                    icon: Icons.description,
                    title: "Description",
                    content: reclamation.Description,
                    iconColor: Colors.blue[900]!,
                    contentColor: Colors.black87,
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildDetailRow(
                    icon: Icons.visibility,
                    title: "Observation des Équipements",
                    content: reclamation.obsequip,
                    iconColor: Colors.blue[900]!,
                    contentColor: Colors.black87,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

 Widget _buildDetailRow({
  required IconData icon,
  required String title,
  required dynamic content,  
  required Color iconColor,
  required Color contentColor,
}) {
  String displayContent;

  if (content is DateTime) {
    if (title == "Heure") {
      displayContent = DateFormat('HH:mm').format(content); 
    } else {
      displayContent = DateFormat('dd/MM/yyyy').format(content);  
    }
  } else {
    displayContent = content.toString();
  }

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
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 16),
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
                displayContent, // Affichage du contenu (formaté)
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

}
