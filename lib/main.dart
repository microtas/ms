import 'package:flutter/material.dart';
import 'package:ms_maintain/Client/HomePage.dart';
import 'package:ms_maintain/Technicien/homepage_technicien.dart';
import 'package:ms_maintain/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      
    );
  }
}

