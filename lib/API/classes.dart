import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'dart:convert';

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
int findLong(XmlElement node, String tagName, {int defaultValue = 0}) {
  final elements = node.findElements(tagName);
  return elements.isNotEmpty
      ? int.tryParse(elements.single.text) ?? defaultValue
      : defaultValue;
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

class Client {
  final String CodeClient;
  final String Raison;
  final int Famille;
  final String Civilite;
  final String Adresse;
  final String Adresse_Suite;
  final String CP;
  final String Gouvernorat;
  final String Pays;
  final String Tel1;
  final String Tel2;
  final String Fax;
  final String Email;
  final String SiteWeb;
  final int Contact;
  final bool Exonere;
  final bool Majoration;
  final String MF;
  final int Remise;
  final int Banque;
  final String AdresseBq;
  final String CompteBq;
  final int Compte;
  final int CodeTarif;
  final String TarifExp;
  final DateTime DebExo;
  final DateTime FinExo;
  final bool TimbFis;
  final int SectAct;
  final String Commercial;
  final String ModPai;
  final double Encours;
  final double EncoursBL;
  final String Pass;

  Client({
  required this.CodeClient,
  required  this.Raison,
  required  this.Famille,
  required  this.Civilite,
  required  this.Adresse,
  required  this.Adresse_Suite,
  required  this.CP,
  required  this.Gouvernorat,
  required  this.Pays,
  required  this.Tel1,
  required  this.Tel2,
  required  this.Fax,
  required  this.Email,
  required  this.SiteWeb,
  required  this.Contact,
  required  this.Exonere,
  required  this.Majoration,
  required  this.MF,
  required  this.Remise,
  required  this.Banque,
  required  this.AdresseBq,
  required  this.CompteBq,
  required  this.Compte,
  required  this.CodeTarif,
  required  this.TarifExp,
  required  this.DebExo,
  required  this.FinExo,
  required  this.TimbFis,
  required  this.SectAct,
  required  this.Commercial,
  required  this.ModPai,
  required  this.Encours,
  required  this.EncoursBL,
  required  this.Pass,
  });

  factory Client.fromXml(XmlElement node) {
    return Client(
      CodeClient: findText(node, 'CodeClient'),
      Raison: findText(node, 'Raison'),
      Famille: findInt(node, 'Famille'),
      Civilite: findText(node, 'Civilite'),
      Adresse: findText(node, 'Adresse'),
      Adresse_Suite: findText(node, 'Adresse_Suite'),
      CP: findText(node, 'CP'),
      Gouvernorat: findText(node, 'Gouvernorat'),
      Pays: findText(node, 'Pays'),
      Tel1: findText(node, 'Tel1'),
      Tel2: findText(node, 'Tel2'),
      Fax: findText(node, 'Fax'),
      Email: findText(node, 'Email'),
      SiteWeb: findText(node, 'SiteWeb'),
      Contact: findInt(node, 'Contact'),
      Exonere: findBool(node, 'Exonere'),
      Majoration: findBool(node, 'Majoration'),
      MF: findText(node, 'MF'),
      Remise: findInt(node, 'Remise'),
      Banque: findInt(node, 'Banque'),
      AdresseBq: findText(node, 'AdresseBq'),
      CompteBq: findText(node, 'CompteBq'),
      Compte: findInt(node, 'Compte'),
      CodeTarif: findInt(node, 'CodeTarif'),
      TarifExp: findText(node, 'TarifExp'),
      DebExo: findDate(node, 'DebExo'),
      FinExo: findDate(node, 'FinExo'),
      TimbFis: findBool(node, 'TimbFis'),
      SectAct: findInt(node, 'SectAct'),
      Commercial: findText(node, 'Commercial'),
      ModPai: findText(node, 'ModPai'),
      Encours: findDouble(node, 'Encours'),
      EncoursBL: findDouble(node, 'EncoursBL'),
      Pass: findText(node, 'Pass'),
    );
  }
}

class Reclamation{
  final int Etat;
  final int eqp;
  final int Id;
  final int Ste;
  final String idREcl;
  final String obsequip;
  final String NomSte;
  final String NumRcl; 
  final String CodeClient;
  final String Resume; 
  final String Description;
  final DateTime Date;
  final DateTime HrEmi;
    



 
  Reclamation({
  required  this.Etat, 
  required  this.NumRcl, 
  required  this.CodeClient, 
  required  this.Resume, 
  required  this.Description, 
  required  this.Date, 
  required  this.HrEmi,
  required  this.Id,
  required  this.Ste, 
  required  this.idREcl, 
  required this.eqp,
  required this.obsequip,
  required this.NomSte,
 }

  );
factory Reclamation.fromXml(XmlElement node) {
  return  Reclamation(

Id:findInt(node, 'Id'),
Ste:findInt(node, 'Ste'),
Etat:findInt(node, 'Etat'),
eqp:findInt(node, 'eqp'),
NumRcl: findText(node, 'NumRcl'),
CodeClient: findText(node, 'CodeClient'),
Resume: findText(node, 'Resume'),
Description: findText(node, 'Description'),
Date: findDate(node, 'Date'), 
HrEmi: findDate(node, 'HrEmi'),
obsequip:findText(node, 'obsequip'), 
NomSte:findText(node, 'NomSte'), 
idREcl:findText(node, 'idREcl'),
);}}




class Equipement {
  final int Code;
  final String Designation;
  final int? Maint;
  final int? Secteur;
  final int? Famille;
  final int? Type;
  final double? CoutArr;
  final int? NbArr;
  final int? PerArr;
  final int? UnArr;
  final int? Nature;
  final int? Compteur;
  final int? Direction;
  final int? Service;
  final int? Section;
  final String? NumSerie;
  final String? NumModele;
  final String? Fabricant;
  final DateTime? DatAch;
  final DateTime? DatSvc;
  final String? CodFrn;
  final String? Fichier;
  final String? Photo;
  final int? Prg;
  final String? LogUser;
  final String? Technique;
  final String? Obs;
  final int? Agence;
  final int? Etage;
  final int? Bureau;
  final String? Emplacement;
  final String? CodInv;
  final int? Etat;
  final String? Client;
  final int? Entree;
  final int? Ste;

  Equipement({
   required this.Code,
   required this.Designation,
    this.Maint,
    this.Secteur,
    this.Famille,
    this.Type,
    this.CoutArr,
    this.NbArr,
    this.PerArr,
    this.UnArr,
    this.Nature,
    this.Compteur,
    this.Direction,
    this.Service,
    this.Section,
    this.NumSerie,
    this.NumModele,
    this.Fabricant,
    this.DatAch,
    this.DatSvc,
    this.CodFrn,
    this.Fichier,
    this.Photo,
    this.Prg,
    this.LogUser,
    this.Technique,
    this.Obs,
    this.Agence,
    this.Etage,
    this.Bureau,
    this.Emplacement,
    this.CodInv,
    this.Etat,
    this.Client,
    this.Entree,
    this.Ste,
  });

  factory Equipement.fromXml(XmlElement node) {
    return Equipement(
      Code: findInt(node, 'Code'),
      Designation: findText(node, 'Designation'),
      Maint: findInt(node, 'Maint'),
      Secteur: findInt(node, 'Secteur'),
      Famille: findInt(node, 'Famille'),
      Type: findInt(node, 'Type'),
      CoutArr: findDouble(node, 'CoutArr'),
      NbArr: findInt(node, 'NbArr'),
      PerArr: findInt(node, 'PerArr'),
      UnArr: findInt(node, 'UnArr'),
      Nature: findInt(node, 'Nature'),
      Compteur: findInt(node, 'Compteur'),
      Direction: findInt(node, 'Direction'),
      Service: findInt(node, 'Service'),
      Section: findInt(node, 'Section'),
      NumSerie: findText(node, 'NumSerie'),
      NumModele: findText(node, 'NumModele'),
      Fabricant: findText(node, 'Fabricant'),
      DatAch: findDate(node, 'DatAch'),
      DatSvc: findDate(node, 'DatSvc'),
      CodFrn: findText(node, 'CodFrn'),
      Fichier: findText(node, 'Fichier'),
      Photo: findText(node, 'Photo'),
      Prg: findInt(node, 'Prg'),
      LogUser: findText(node, 'LogUser'),
      Technique: findText(node, 'Technique'),
      Obs: findText(node, 'Obs'),
      Agence: findInt(node, 'Agence'),
      Etage: findInt(node, 'Etage'),
      Bureau: findInt(node, 'Bureau'),
      Emplacement: findText(node, 'Emplacement'),
      CodInv: findText(node, 'CodInv'),
      Etat: findInt(node, 'Etat'),
      Client: findText(node, 'Client'),
      Entree: findInt(node, 'Entree'),
      Ste: findInt(node, 'Ste'),
    );
  }
}

