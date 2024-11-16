// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:projetopersistencia/database/app_database.dart';
import 'package:projetopersistencia/models/car.dart';
import 'package:projetopersistencia/screens/cars_list.dart';
import 'package:projetopersistencia/screens/cars_form.dart';
import 'package:projetopersistencia/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }

}



