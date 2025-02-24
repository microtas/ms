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
class Client {
  final String CodeClient;
  final String Raison;
  final String Famille;
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
  final String Contact;
  final bool Exonere;
  final bool Majoration;
  final double MF;
  final double Remise;
  final String Banque;
  final String AdresseBq;
  final String CompteBq;
  final String Compte;
  final String CodeTarif;
  final String TarifExp;
  final DateTime DebExo;
  final DateTime FinExo;
  final double TimbFis;
  final String SectAct;
  final String Commercial;
  final String ModPai;
  final double Encours;
  final double EncoursBL;
  final String Pass;
  final String Code;
  final String Designation;
  final String Maint;
  final String Secteur;
  final String Famille1;
  final String Type;
  final double CoutArr;
  final int NbArr;
  final String PerArr;
  final String UnArr;
  final String Nature;
  final String Compteur;
  final String Direction;
  final String Service;
  final String Section;
  final String NumSerie;
  final String NumModele;
  final String Fabricant;
  final DateTime DatAch;
  final DateTime DatSvc;
  final String CodFrn;
  final String Fichier;
  final String Photo;
  final String Prg;
  final String LogUser;
  final String Technique;
  final String Obs;
  final String Agence;
  final String Etage;
  final String Bureau;
  final String Emplacement;
  final String CodInv;
  final String Etat;
  final String ClientRef;
  final DateTime Entree;
  final String Ste;
  final String QRCode;
  final double TxFct;
  final String CodeClient1;
  final String Raison1;
  final String Famille2;
  final String Civilite1;
  final String Adresse1;
  final String Adresse_Suite1;
  final String CP1;
  final String Gouvernorat1;
  final String Pays1;
  final String Tel11;
  final String Tel21;
  final String Fax1;
  final String Email1;
  final String SiteWeb1;
  final String Contact1;
  final bool Exonere1;
  final bool Majoration1;
  final double MF1;
  final double Remise1;
  final String Banque1;
  final String AdresseBq1;
  final String CompteBq1;
  final String Compte1;
  final String CodeTarif1;
  final double TarifExp1;
  final DateTime DebExo1;
  final DateTime FinExo1;
  final double TimbFis1;
  final String SectAct1;
  final String Commercial1;
  final String ModPai1;
  final double Encours1;
  final double EncoursBL1;
  final String Pass1;
  final String Code1;
  final String Designation1;
  final String Maint1;
  final String Secteur1;
  final String Famille3;
  final String Type1;
  final double CoutArr1;
  final int NbArr1;
  final String PerArr1;
  final String UnArr1;
  final String Nature1;
  final String Compteur1;
  final String Direction1;
  final String Service1;
  final String Section1;
  final String NumSerie1;
  final String NumModele1;
  final String Fabricant1;
  final DateTime DatAch1;
  final DateTime DatSvc1;
  final String CodFrn1;
  final String Fichier1;
  final String Photo1;
  final String Prg1;
  final String LogUser1;
  final String Technique1;
  final String Obs1;
  final String Agence1;
  final String Etage1;
  final String Bureau1;
  final String Emplacement1;
  final String CodInv1;
  final String Etat1;
  final String Client1;
  final DateTime Entree1;
  final String Ste1;
  final String QRCode1;
  final double TxFct1;

  Client({
    required this.CodeClient,
    required this.Raison,
    required this.Famille,
    required this.Civilite,
    required this.Adresse,
    required this.Adresse_Suite,
    required this.CP,
    required this.Gouvernorat,
    required this.Pays,
    required this.Tel1,
    required this.Tel2,
    required this.Fax,
    required this.Email,
    required this.SiteWeb,
    required this.Contact,
    required this.Exonere,
    required this.Majoration,
    required this.MF,
    required this.Remise,
    required this.Banque,
    required this.AdresseBq,
    required this.CompteBq,
    required this.Compte,
    required this.CodeTarif,
    required this.TarifExp,
    required this.DebExo,
    required this.FinExo,
    required this.TimbFis,
    required this.SectAct,
    required this.Commercial,
    required this.ModPai,
    required this.Encours,
    required this.EncoursBL,
    required this.Pass,
    required this.Code,
    required this.Designation,
    required this.Maint,
    required this.Secteur,
    required this.Famille1,
    required this.Type,
    required this.CoutArr,
    required this.NbArr,
    required this.PerArr,
    required this.UnArr,
    required this.Nature,
    required this.Compteur,
    required this.Direction,
    required this.Service,
    required this.Section,
    required this.NumSerie,
    required this.NumModele,
    required this.Fabricant,
    required this.DatAch,
    required this.DatSvc,
    required this.CodFrn,
    required this.Fichier,
    required this.Photo,
    required this.Prg,
    required this.LogUser,
    required this.Technique,
    required this.Obs,
    required this.Agence,
    required this.Etage,
    required this.Bureau,
    required this.Emplacement,
    required this.CodInv,
    required this.Etat,
    required this.ClientRef,
    required this.Entree,
    required this.Ste,
    required this.QRCode,
    required this.TxFct,
    required this.CodeClient1,
    required this.Raison1,
    required this.Famille2,
    required this.Civilite1,
    required this.Adresse1,
    required this.Adresse_Suite1,
    required this.CP1,
    required this.Gouvernorat1,
    required this.Pays1,
    required this.Tel11,
    required this.Tel21,
    required this.Fax1,
    required this.Email1,
    required this.SiteWeb1,
    required this.Contact1,
    required this.Exonere1,
    required this.Majoration1,
    required this.MF1,
    required this.Remise1,
    required this.Banque1,
    required this.AdresseBq1,
    required this.CompteBq1,
    required this.Compte1,
    required this.CodeTarif1,
    required this.TarifExp1,
    required this.DebExo1,
    required this.FinExo1,
    required this.TimbFis1,
    required this.SectAct1,
    required this.Commercial1,
    required this.ModPai1,
    required this.Encours1,
    required this.EncoursBL1,
    required this.Pass1,
    required this.Code1,
    required this.Designation1,
    required this.Maint1,
    required this.Secteur1,
    required this.Famille3,
    required this.Type1,
    required this.CoutArr1,
    required this.NbArr1,
    required this.PerArr1,
    required this.UnArr1,
    required this.Nature1,
    required this.Compteur1,
    required this.Direction1,
    required this.Service1,
    required this.Section1,
    required this.NumSerie1,
    required this.NumModele1,
    required this.Fabricant1,
    required this.DatAch1,
    required this.DatSvc1,
    required this.CodFrn1,
    required this.Fichier1,
    required this.Photo1,
    required this.Prg1,
    required this.LogUser1,
    required this.Technique1,
    required this.Obs1,
    required this.Agence1,
    required this.Etage1,
    required this.Bureau1,
    required this.Emplacement1,
    required this.CodInv1,
    required this.Etat1,
    required this.Client1,
    required this.Entree1,
    required this.Ste1,
    required this.QRCode1,
    required this.TxFct1,
  });

  factory Client.fromXml(XmlElement node) {
    return Client(
      CodeClient: findText(node, 'CodeClient'),
      Raison: findText(node, 'Raison'),
      Famille: findText(node, 'Famille'),
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
      Contact: findText(node, 'Contact'),
      Exonere: findBool(node, 'Exonere'),
      Majoration: findBool(node, 'Majoration'),
      MF: findDouble(node, 'MF'),
      Remise: findDouble(node, 'Remise'),
      Banque: findText(node, 'Banque'),
      AdresseBq: findText(node, 'AdresseBq'),
      CompteBq: findText(node, 'CompteBq'),
      Compte: findText(node, 'Compte'),
      CodeTarif: findText(node, 'CodeTarif'),
      TarifExp: findText(node, 'TarifExp'),
      DebExo: findDate(node, 'DebExo'),
      FinExo: findDate(node, 'FinExo'),
      TimbFis: findDouble(node, 'TimbFis'),
      SectAct: findText(node, 'SectAct'),
      Commercial: findText(node, 'Commercial'),
      ModPai: findText(node, 'ModPai'),
      Encours: findDouble(node, 'Encours'),
      EncoursBL: findDouble(node, 'EncoursBL'),
      Pass: findText(node, 'Pass'),
      Code: findText(node, 'Code'),
      Designation: findText(node, 'Designation'),
      Maint: findText(node, 'Maint'),
      Secteur: findText(node, 'Secteur'),
      Famille1: findText(node, 'Famille1'),
      Type: findText(node, 'Type'),
      CoutArr: findDouble(node, 'CoutArr'),
      NbArr: findInt(node, 'NbArr'),
      PerArr: findText(node, 'PerArr'),
      UnArr: findText(node, 'UnArr'),
      Nature: findText(node, 'Nature'),
      Compteur: findText(node, 'Compteur'),
      Direction: findText(node, 'Direction'),
      Service: findText(node, 'Service'),
      Section: findText(node, 'Section'),
      NumSerie: findText(node, 'NumSerie'),
      NumModele: findText(node, 'NumModele'),
      Fabricant: findText(node, 'Fabricant'),
      DatAch: findDate(node, 'DatAch'),
      DatSvc: findDate(node, 'DatSvc'),
      CodFrn: findText(node, 'CodFrn'),
      Fichier: findText(node, 'Fichier'),
      Photo: findText(node, 'Photo'),
      Prg: findText(node, 'Prg'),
      LogUser: findText(node, 'LogUser'),
      Technique: findText(node, 'Technique'),
      Obs: findText(node, 'Obs'),
      Agence: findText(node, 'Agence'),
      Etage: findText(node, 'Etage'),
      Bureau: findText(node, 'Bureau'),
      Emplacement: findText(node, 'Emplacement'),
      CodInv: findText(node, 'CodInv'),
      Etat: findText(node, 'Etat'),
      ClientRef: findText(node, 'Client'),
      Entree: findDate(node, 'Entree'),
      Ste: findText(node, 'Ste'),
      QRCode: findText(node, 'QRCode'),
      TxFct: findDouble(node, 'TxFct'),
      CodeClient1: findText(node, 'CodeClient1'),
      Raison1: findText(node, 'Raison1'),
      Famille2: findText(node, 'Famille2'),
      Civilite1: findText(node, 'Civilite1'),
      Adresse1: findText(node, 'Adresse1'),
      Adresse_Suite1: findText(node, 'Adresse_Suite1'),
      CP1: findText(node, 'CP1'),
      Gouvernorat1: findText(node, 'Gouvernorat1'),
      Pays1: findText(node, 'Pays1'),
      Tel11: findText(node, 'Tel11'),
      Tel21: findText(node, 'Tel21'),
      Fax1: findText(node, 'Fax1'),
      Email1: findText(node, 'Email1'),
      SiteWeb1: findText(node, 'SiteWeb1'),
      Contact1: findText(node, 'Contact1'),
      Exonere1: findBool(node, 'Exonere1'),
      Majoration1: findBool(node, 'Majoration1'),
      MF1: findDouble(node, 'MF1'),
      Remise1: findDouble(node, 'Remise1'),
      Banque1: findText(node, 'Banque1'),
      AdresseBq1: findText(node, 'AdresseBq1'),
      CompteBq1: findText(node, 'CompteBq1'),
      Compte1: findText(node, 'Compte1'),
      CodeTarif1: findText(node, 'CodeTarif1'),
      TarifExp1: findDouble(node, 'TarifExp1'),
      DebExo1: findDate(node, 'DebExo1'),
      FinExo1: findDate(node, 'FinExo1'),
      TimbFis1: findDouble(node, 'TimbFis1'),
      SectAct1: findText(node, 'SectAct1'),
      Commercial1: findText(node, 'Commercial1'),
      ModPai1: findText(node, 'ModPai1'),
      Encours1: findDouble(node, 'Encours1'),
      EncoursBL1: findDouble(node, 'EncoursBL1'),
      Pass1: findText(node, 'Pass1'),
      Code1: findText(node, 'Code1'),
      Designation1: findText(node, 'Designation1'),
      Maint1: findText(node, 'Maint1'),
      Secteur1: findText(node, 'Secteur1'),
      Famille3: findText(node, 'Famille3'),
      Type1: findText(node, 'Type1'),
      CoutArr1: findDouble(node, 'CoutArr1'),
      NbArr1: findInt(node, 'NbArr1'),
      PerArr1: findText(node, 'PerArr1'),
      UnArr1: findText(node, 'UnArr1'),
      Nature1: findText(node, 'Nature1'),
      Compteur1: findText(node, 'Compteur1'),
      Direction1: findText(node, 'Direction1'),
      Service1: findText(node, 'Service1'),
      Section1: findText(node, 'Section1'),
      NumSerie1: findText(node, 'NumSerie1'),
      NumModele1: findText(node, 'NumModele1'),
      Fabricant1: findText(node, 'Fabricant1'),
      DatAch1: findDate(node, 'DatAch1'),
      DatSvc1: findDate(node, 'DatSvc1'),
      CodFrn1: findText(node, 'CodFrn1'),
      Fichier1: findText(node, 'Fichier1'),
      Photo1: findText(node, 'Photo1'),
      Prg1: findText(node, 'Prg1'),
      LogUser1: findText(node, 'LogUser1'),
      Technique1: findText(node, 'Technique1'),
      Obs1: findText(node, 'Obs1'),
      Agence1: findText(node, 'Agence1'),
      Etage1: findText(node, 'Etage1'),
      Bureau1: findText(node, 'Bureau1'),
      Emplacement1: findText(node, 'Emplacement1'),
      CodInv1: findText(node, 'CodInv1'),
      Etat1: findText(node, 'Etat1'),
      Client1: findText(node, 'Client1'),
      Entree1: findDate(node, 'Entree1'),
      Ste1: findText(node, 'Ste1'),
      QRCode1: findText(node, 'QRCode1'),
      TxFct1: findDouble(node, 'TxFct1'),
    );
  }
}


class Reclamation{
  final int Id;
  final int Ste;
  final int Etat;
  final int Id1;
  final int Ste1;
  final int Eqp;
  final int Id2;
  final int Ste2;
  final int Etat1;
  final int Id3;
  final int Ste3;
  final int Eqp1;
  final String NumRcl; 
  final String CodeClient;
  final String Resume; 
  final String Description;
  final String NumRcl1;
  final String Obs;
  final String NumRcl2;
  final String CodeClient1;
  final String Resume1;
  final String Description1;
  final String NumRcl3;
  final String Obs1;
  final DateTime Date;
  final DateTime HrEmi;
  final DateTime Date1;
  final DateTime HrEmi1;
  Reclamation({
  required  this.Id,
  required  this.Ste, 
  required  this.Etat, 
  required  this.Id1, 
  required  this.Ste1, 
  required  this.Eqp, 
  required  this.Id2, 
  required  this.Ste2, 
  required  this.Etat1, 
  required  this.Id3, 
  required  this.Ste3, 
  required  this.Eqp1, 
  required  this.NumRcl, 
  required  this.CodeClient, 
  required  this.Resume, 
  required  this.Description, 
  required  this.NumRcl1, 
  required  this.Obs, 
  required  this.NumRcl2, 
  required  this.CodeClient1, 
  required  this.Resume1, 
  required  this.Description1, 
  required  this.NumRcl3, 
  required  this.Obs1, 
  required  this.Date, 
  required  this.HrEmi, 
  required  this.Date1, 
  required  this.HrEmi1}

  );
factory Reclamation.fromXml(XmlElement node) {
  return  Reclamation(
Id:findInt(node, 'Id'),
Ste:findInt(node, 'Ste'),
Etat:findInt(node, 'Etat'),
Id1:findInt(node, 'Id1'),
Ste1:findInt(node, 'Ste1'),
Eqp:findInt(node, 'Eqp'),
Id2:findInt(node, 'Id2'),
Ste2:findInt(node, 'Ste2'),
Etat1:findInt(node, 'Etat1'),
Id3:findInt(node, 'Id3'),
Ste3:findInt(node, 'Ste3'),
Eqp1:findInt(node, 'Eqp1'),
NumRcl: findText(node, 'NumRcl'),
CodeClient: findText(node, 'CodeClient'),
Resume: findText(node, 'Resume'),
Description: findText(node, 'Description'),
NumRcl1: findText(node, 'NumRcl1'),
Obs: findText(node, 'Obs'), 
NumRcl2: findText(node, 'NumRcl2'),
CodeClient1: findText(node, 'CodeClient1'),
Resume1: findText(node, 'Resume1'),
Description1:findText(node, 'Description1'), 
NumRcl3: findText(node, 'NumRcl3'), 
Obs1: findText(node, 'Obs1'),
Date: findDate(node, 'Date'), 
HrEmi: findDate(node, 'HrEmi'),
Date1: findDate(node, 'Date1'),
HrEmi1: findDate(node, 'HrEmi1'),
);}}

  
