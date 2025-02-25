import 'package:ms_maintain/API/classes.dart';
import 'package:xml/xml.dart';

List<User> parseUser(String xmlResponse) {
  try {
      // Parse the XML string into a document

    final document = XmlDocument.parse(xmlResponse);
      // Extract all `<Table>` elements (case-sensitive)
    final tableElements = document.findAllElements('Table');
      // Map each `<Table>` element to an `Emploi` object
    return tableElements.map((node) =>User.fromXml(node)).toList();
  } catch (e) {
    print('Erreur lors de l\'analyse du XML: $e');
    return [];
  }
}
List<Client> parseClient(String xmlResponse) {
  try {
      // Parse the XML string into a document

    final document = XmlDocument.parse(xmlResponse);
      // Extract all `<Table>` elements (case-sensitive)
    final tableElements = document.findAllElements('Table');
      // Map each `<Table>` element to an `Emploi` object
    return tableElements.map((node) =>Client.fromXml(node)).toList();
  } catch (e) {
    print('Erreur lors de l\'analyse du XML: $e');
    return [];
  }
}
List<Reclamation> parseReclamation(String xmlResponse) {
  try {
      // Parse the XML string into a document

    final document = XmlDocument.parse(xmlResponse);
      // Extract all `<Table>` elements (case-sensitive)
    final tableElements = document.findAllElements('Table');
      // Map each `<Table>` element to an `Emploi` object
    return tableElements.map((node) =>Reclamation.fromXml(node)).toList();
  } catch (e) {
    print('Erreur lors de l\'analyse du XML: $e');
    return [];
  }
}
List<Equipement> parseEquipement(String xmlResponse) {
  try {
      // Parse the XML string into a document

    final document = XmlDocument.parse(xmlResponse);
      // Extract all `<Table>` elements (case-sensitive)
    final tableElements = document.findAllElements('Table');
      // Map each `<Table>` element to an `Emploi` object
    return tableElements.map((node) =>Equipement.fromXml(node)).toList();
  } catch (e) {
    print('Erreur lors de l\'analyse du XML: $e');
    return [];
  }
}