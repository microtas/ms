import 'package:flutter/material.dart';
import 'package:ms_maintain/classes.dart';

class ReclamationPage extends StatefulWidget {
  final Function(Reclamation) onReclamationAdded;

  ReclamationPage({required this.onReclamationAdded});

  @override
  _ReclamationPageState createState() => _ReclamationPageState();
}

class _ReclamationPageState extends State<ReclamationPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedSociete;
  String? _selectedEquipement;
  bool _showEquipementFields = false;

  final TextEditingController _remarqueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _panneController = TextEditingController();

  final List<String> _societes = ['Société A', 'Société B', 'Société C'];
  final List<String> _equipements = ['Ordinateur', 'Imprimante', 'Scanner', 'Téléphone'];
  final List<String> _selectedEquipements = []; // Liste d'équipements sélectionnés

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Réclamation", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Liste déroulante des sociétés
                _buildDropdownField(
                  label: "Choisir une société",
                  value: _selectedSociete,
                  items: _societes,
                  icon: Icons.business,
                  onChanged: (value) {
                    setState(() {
                      _selectedSociete = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                
                // Champ Remarque
                _buildTextField(
                  controller: _remarqueController,
                  label: "Remarque",
                  icon: Icons.comment,
                ),
                const SizedBox(height: 20),
                
                // Champ Description
                _buildTextField(
                  controller: _descriptionController,
                  label: "Description",
                  icon: Icons.description,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                
                // Bouton pour afficher les équipements
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showEquipementFields = !_showEquipementFields;
                    });
                  },
                  icon: Icon(
                    _showEquipementFields ? Icons.remove_circle : Icons.add_circle,
                    color: Colors.white,
                  ),
                  label: Text(
                    _showEquipementFields ? "Masquer Équipements" : "Ajouter un Équipement",
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Affichage conditionnel des champs équipements
                if (_showEquipementFields) ...[
                  _buildDropdownField(
                    label: "Choisir un équipement",
                    value: _selectedEquipement,
                    items: _equipements,
                    icon: Icons.devices_other,
                    onChanged: (value) {
                      setState(() {
                        if (value != null && !_selectedEquipements.contains(value)) {
                          _selectedEquipements.add(value); // Ajouter un équipement à la liste
                        }
                        _selectedEquipement = null; // Réinitialiser la sélection
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  _buildTextField(
                    controller: _panneController,
                    label: "Description de la panne",
                    icon: Icons.build,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                
                  if (_selectedEquipements.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Équipements sélectionnés :",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        ..._selectedEquipements.map((equipement) {
                          return ListTile(
                            title: Text(equipement),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _selectedEquipements.remove(equipement); // Supprimer l'équipement de la liste
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  const SizedBox(height: 20),
                ],
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Reclamation newReclamation = Reclamation(
                          societe: _selectedSociete!,
                          remarque: _remarqueController.text,
                          description: _descriptionController.text,
                          equipement: _selectedEquipements.isEmpty ? null : _selectedEquipements.join(", "), 
                          panne: _panneController.text,
                          etat: 0, 
                        );
                        
                        widget.onReclamationAdded(newReclamation);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Réclamation envoyée avec succès !")),
                        );

                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Soumettre",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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

  // Fonction pour construire un champ de texte
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue[900]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 13, 71, 161), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
    );
  }

  // Fonction pour construire un champ déroulant
  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue[900]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 13, 71, 161), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? "Veuillez faire un choix" : null,
    );
  }
}
 