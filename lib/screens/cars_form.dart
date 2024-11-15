import 'package:flutter/material.dart';
import 'package:projetopersistencia/database/app_database.dart';
import 'package:projetopersistencia/models/car.dart';

class CarForm extends StatefulWidget {

  @override
  State<CarForm> createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _tipoCombustivelController = TextEditingController();

  @override
  Widget build(Object BuildContext) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color.fromRGBO(0, 48, 92, 1),
          title: const Text(
            "Novo Carro",
            style: TextStyle(color: Colors.white, fontSize: 28),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _modeloController,
              decoration: const InputDecoration(
                labelText: 'Modelo'
              ),
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              controller: _marcaController,
              decoration: const InputDecoration(
                labelText: 'Marca'
              ),
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              controller: _anoController,
              decoration: const InputDecoration(
                labelText: 'Ano'
              ),
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _corController,
              decoration: const InputDecoration(
                labelText: 'Cor'
              ),
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              controller: _tipoCombustivelController,
              decoration: const InputDecoration(
                labelText: 'Tipo combustivel'
              ),
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox (
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 48, 92, 1),
                    textStyle: const TextStyle(fontSize: 20),
                    foregroundColor: Colors.white
                  ),
                  child: const Text(
                    'Cadastrar',
                  ),                  
                  onPressed: () {
                    final String modelo = _modeloController.text;
                    final String marca = _marcaController.text;
                    final int? ano = int.tryParse(_anoController.text);
                    final String cor = _corController.text;
                    final String tipo_combustivel = _tipoCombustivelController.text;
                    final Car newCar = Car(0, modelo, marca, ano!, cor, tipo_combustivel);
                    save(newCar).then((id) => Navigator.pop(context, newCar));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

