import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class InterventionFormPage extends StatefulWidget {
  final Map<String, String>? existingIntervention;

  InterventionFormPage({this.existingIntervention});

  @override
  _InterventionFormPageState createState() => _InterventionFormPageState();
}

class _InterventionFormPageState extends State<InterventionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  List<String> equipmentList = [
    'Équipement 1',
    'Équipement 2',
    'Équipement 3',
    'Équipement 4',
    'Équipement 5',
  ];

  List<String> _selectedEquipments = [];

  @override
  void initState() {
    super.initState();

    // Si une intervention existante est passée, initialiser les champs
    if (widget.existingIntervention != null) {
      _taskDescriptionController.text =
          widget.existingIntervention?['taskDescription'] ?? '';
      _selectedEquipments =
          (widget.existingIntervention?['equipments'] ?? '').split(', ');
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final taskDescription = _taskDescriptionController.text;
      final selectedEquipments = _selectedEquipments.join(', ');

      // Création de la fiche d'intervention
      final intervention = {
        'taskDescription': taskDescription,
        'equipments': selectedEquipments,
      };

      Navigator.pop(context, intervention);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.existingIntervention == null
              ? 'Créer une Fiche d\'Intervention'
              : 'Modifier la Fiche d\'Intervention',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.existingIntervention == null
                    ? 'Créer une Fiche d\'Intervention'
                    : 'Modifier une Fiche d\'Intervention',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
              SizedBox(height: 20),

              // Description de la tâche
              TextFormField(
                controller: _taskDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Description de la tâche',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 13, 71, 161)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 13, 71, 161)),
                  ),
                  prefixIcon: Icon(Icons.description, color: Colors.amber[600]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez décrire la tâche';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Espacement plus important

              // Équipements utilisés
              Text(
                'Équipements utilisés',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
              SizedBox(height: 10),
              MultiSelectDialogField(
                items: equipmentList
                    .map((equipment) =>
                        MultiSelectItem<String>(equipment, equipment))
                    .toList(),
                title: Text("Sélectionnez des équipements",
                    style: TextStyle(color: Colors.blue[900])),
                selectedColor: Colors.amber[600],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey),
                ),
                buttonText: Text("Sélectionner des équipements",
                    style: TextStyle(color: Colors.grey)),
                onConfirm: (results) {
                  setState(() {
                    _selectedEquipments = List<String>.from(results);
                  });
                },
              ),
              SizedBox(height: 30), // Espacement plus important

              // Utilisation de Spacer pour pousser le bouton en bas
              Expanded(child: SizedBox()),

              // Bouton Soumettre
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600],
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                    elevation: 3, // Effet de profondeur subtile
                  ),
                  child:
                      Text('Soumettre', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
