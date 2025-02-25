import 'package:flutter/material.dart';
import 'package:ms_maintain/API/HttpRequest.dart';
import 'package:ms_maintain/API/classes.dart';
import 'package:ms_maintain/API/paresXML.dart';
import 'package:ms_maintain/Client/HomePage.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ReclamationPage extends StatefulWidget {
  final Function(Reclamation) onReclamationAdded;

  ReclamationPage({required this.onReclamationAdded});

  @override
  _ReclamationPageState createState() => _ReclamationPageState();
}

class _ReclamationPageState extends State<ReclamationPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedEquipement;
  bool _showEquipementFields = false;

  final TextEditingController _remarqueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _panneController = TextEditingController();

  bool _isLoading = false;
  final String CodeClient = '1'; // Remplacez par le client actuel

  List<Equipement> equipements = [];
  List<Reclamation> reclamations = [];

  @override
  void initState() {
    super.initState();
    fetchEquipemnt();
  }

  Future<void> fetchEquipemnt() async {
    try {
      final response = await THttpHelper.get<Equipement>(
        'GetEqpClient',
        parseEquipement,
         queryParameters: {'codeclient': '1'},
      );
      setState(() {
        equipements = response;
        print('Equipements récupérés: $equipements');
      });
    } catch (e) {
      print("Erreur lors de l'appel de l'API : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la récupération des équipements")),
      );
            print("Erreur lors de la récupération des équipements");

    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      bool allSuccess = true;

      setState(() {
        _isLoading = true;
      });

      Map<String, String> body = {
        'equipements': _selectedEquipement ?? '',
        'codeclient': CodeClient,
        'Rsm': _remarqueController.text,
        'description': _descriptionController.text,
        'Obs': _panneController.text,
      };
      print(body);

      try {
        bool success = await THttpHelper.postBooleen(
          'CreerReclamation',
          body,
          (response) {
            return response;
          },
        );

        if (!success) {
          allSuccess = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de l\'enregistrement de la réclamation')),
          );
        }

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Réclamation créée avec succès!')),
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        }
      } catch (e) {
        allSuccess = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'envoi des données')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Réclamation"),
        backgroundColor: Colors.blue[900],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField(controller: _remarqueController, label: "Remarque", icon: Icons.comment),
                    _buildTextField(controller: _descriptionController, label: "Description", icon: Icons.description, maxLines: 3),
                   // _buildTextField(controller: _panneController, label: "Panne", icon: Icons.padding),

                    if (equipements.isNotEmpty)
                      MultiSelectDialogField<Equipement>(
                        items: equipements.map((equipement) => MultiSelectItem<Equipement>(equipement, equipement.Designation)).toList(),
                        title: Text("Choisir des équipements"),
                        selectedColor: Colors.blue[900],
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        buttonIcon: Icon(Icons.devices_other, color: Colors.blue[900]),
                        buttonText: Text(
                          "Sélectionner des équipements",
                          style: TextStyle(color: Colors.blue[900], fontSize: 16),
                        ),
                        onConfirm: (values) {
                          setState(() {
                            _selectedEquipement = values.map((e) => e.Code.toString()).join(',');
                            print("Équipements sélectionnés: $_selectedEquipement");
                          });
                        },
                        validator: (values) => (values == null || values.isEmpty) ? "Veuillez choisir au moins un équipement" : null,
                      ),
                    _buildTextField(controller: _panneController, label: "Description de la panne", icon: Icons.build, maxLines: 3),

                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text("Soumettre"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue[900]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
    );
  }
}
