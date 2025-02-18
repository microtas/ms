class Reclamation {
  final String societe;
  final String remarque;
  final String description;
  final String? equipement;
  final String? panne;
  final int etat; 
  Reclamation({
    required this.societe,
    required this.remarque,
    required this.description,
    this.equipement,
    this.panne,
    required this.etat, 
  });
}