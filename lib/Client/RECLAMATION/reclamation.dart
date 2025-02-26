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
  bool _isLoadingEquipements = false;

  final TextEditingController _remarqueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _panneController = TextEditingController();

  bool _isLoading = false;
  final String CodeClient = '1';

  List<Equipement> equipements = [];
  List<Reclamation> reclamations = [];

  @override
  void initState() {
    super.initState();
    fetchEquipemnt();
  }

  Future<void> fetchEquipemnt() async {
    setState(() {
      _isLoadingEquipements = true;
    });

    try {
      final response = await THttpHelper.get<Equipement>(
        'GetEqpClient',
        parseEquipement,
        queryParameters: {'codeclient': '1'},
      );
      setState(() {
        equipements = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la récupération des équipements")),
      );
    } finally {
      setState(() {
        _isLoadingEquipements = false;
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      Map<String, String> body = {
        'equipements': _selectedEquipement! + ' ',
        'codeclient': CodeClient,
        'Rsm': _remarqueController.text,
        'description': _descriptionController.text,
        'Obs': _panneController.text,
      };

      try {
        bool success = await THttpHelper.postBooleen(
          'CreerReclamation',
          body,
          (response) => response,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Réclamation créée avec succès!')),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de l\'enregistrement de la réclamation')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'envoi des données')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Réclamation",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
        backgroundColor: Colors.blue[900],
        elevation: 4.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(_remarqueController, "Remarque", Icons.comment),
                      _buildTextField(_descriptionController, "Description", Icons.description, maxLines: 3),
                      
                      if (_isLoadingEquipements)
                        Center(child: CircularProgressIndicator()),
                      if (!_isLoadingEquipements && equipements.isNotEmpty)
                        MultiSelectDialogField<Equipement>(
                          items: equipements.map((e) => MultiSelectItem(e, e.Designation)).toList(),
                          title: Text("Choisir des équipements"),
                          selectedColor: Colors.blue[900],
                          buttonIcon: Icon(Icons.devices_other, color: Colors.blue[900]),
                          buttonText: Text("Sélectionner des équipements", style: TextStyle(color: Colors.blue[900])),
                          onConfirm: (values) {
                            setState(() {
                              _selectedEquipement = values.map((e) => e.Code.toString()).join(',');
                              _panneController.text = values.map((e) => "Panne pour équipement : ${e.Code}").join(', ');
                            });
                          },
                        ),
                      
                      _buildTextField(_panneController, "Description de la panne", Icons.build, maxLines: 3),
                      SizedBox(height: 40),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: _submit,
                          icon: Icon(Icons.send,color: Colors.white,),
                          label: Text("Soumettre",style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[600],
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue[900]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue[900]!),
          ),
        ),
        maxLines: maxLines,
        validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
      ),
    );
  }
}
