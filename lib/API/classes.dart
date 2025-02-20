import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'dart:convert';

// Méthodes utilitaires pour extraire des valeurs sûres à partir de XML
//Trouver la valeur texte associée à un tag XML spécifique.
String findText(XmlElement node, String tagName, {String defaultValue = ''}) {
  final elements = node.findElements(tagName);
  return elements.isNotEmpty ? elements.single.text : defaultValue;
}

int findInt(XmlElement node, String tagName, {int defaultValue = 0}) {
  final elements = node.findElements(tagName);
  return elements.isNotEmpty
      ? int.tryParse(elements.single.text) ?? defaultValue
      : defaultValue;
}

DateTime findDate(XmlElement node, String tagName, {DateTime? defaultValue}) {
  final elements = node.findElements(tagName);
  if (elements.isNotEmpty) {
    try {
      return DateTime.parse(elements.single.text);
    } catch (_) {
      return defaultValue ?? DateTime(1970, 1, 1);
    }
  }
  return defaultValue ?? DateTime(1970, 1, 1);
}

double findDouble(XmlElement node, String tagName) {
  final element = node.getElement(tagName);
  if (element != null && element.text.isNotEmpty) {
    return double.parse(element.text);
  }
  throw ArgumentError('Missing or invalid <$tagName> in XML');
}
bool findBool(XmlElement node, String tagName, {bool defaultValue = false}) {
  final elements = node.findElements(tagName);
  return elements.isNotEmpty
      ? (elements.single.text.toLowerCase() == 'true')
      : defaultValue;
}

class User{
  final String Login;
  final String Password;
  final String Nom;
  final String Email;
  final int Profil;
  final int  Operateur;
  final bool Connecte;
  User( { 
  required this.Login,
  required this.Password,
  required this.Nom, 
  required this.Email, 
  required this.Profil, 
  required this.Operateur,
  required  this.Connecte,
});
  factory User.fromXml(XmlElement node) {
    return User(
      Login: findText(node, 'Login'),
      Password: findText(node, 'Password'),
      Nom: findText(node, 'Nom'),
      Email: findText(node, 'Email'), 
      Profil: findInt(node, 'Profil'),
      Operateur: findInt(node, 'Operateur'),
      Connecte: findBool(node, 'Connecte') ,

       );
}
}
  
