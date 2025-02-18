import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class InterventionFormPage extends StatefulWidget {
  @override
  _InterventionFormPageState createState() => _InterventionFormPageState();
}

class _InterventionFormPageState extends State<InterventionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskDescriptionController = TextEditingController();

  List<String> equipmentList = [
    'Équipement 1',
    'Équipement 2',
    'Équipement 3',
    'Équipement 4',
    'Équipement 5',
  ];

  List<String> _selectedEquipments = [];

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
      appBar: AppBar(
        title: const Text('Gestion des Fiches d\'Intervention', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Créer une Fiche d\'Intervention',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _taskDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description de la tâche',
                    
                    border: OutlineInputBorder(

                    ),
                    prefixIcon: Icon(Icons.description, color: Colors.teal),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez décrire la tâche';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Équipements utilisés', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
                const SizedBox(height: 10),
                MultiSelectDialogField(
                  items: equipmentList
                      .map((equipment) => MultiSelectItem<String>(equipment, equipment))
                      .toList(),
                  title: const Text("Sélectionnez des équipements", style: TextStyle(color: Colors.teal)),
                  selectedColor: Colors.teal,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.teal),
                  ),
                  buttonText: const Text("Sélectionner des équipements", style: TextStyle(color: Colors.grey)),
                  onConfirm: (results) {
                    setState(() {
                      _selectedEquipments = List<String>.from(results);
                    });
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ), 
                    child: const Text('Soumettre', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}