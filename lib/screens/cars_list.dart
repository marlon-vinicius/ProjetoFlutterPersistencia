// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:projetopersistencia/database/app_database.dart';
import 'package:projetopersistencia/screens/cars_form.dart';

import '../models/car.dart';

class CarsList extends StatefulWidget {

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  final TextEditingController _searchController = TextEditingController();
  List<Car> _todosCarros = [];
  List<Car> _carrosFiltrados = [];

  @override
  void initState() {
    super.initState();
    _carregarCarros();
  }

  void _carregarCarros() async {
    List<Car> cars = await findAll();
    setState(() {
      _todosCarros = cars;
      _carrosFiltrados = cars;
    });
  }

  void _filtrarCarros(String query) {
    if (query.isEmpty) {
      setState(() {
        _carrosFiltrados = _todosCarros;
      });
    } else {
      findCarsByModel(query).then((carrosFiltrados) {
        setState(() {
          _carrosFiltrados = carrosFiltrados;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 48, 92, 1),
        title: const Text(
          "Lista de carros",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar modelo',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _filtrarCarros(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final Car car = _carrosFiltrados[index];
                return _CarItem(
                  car,
                  onDelete: () {
                    deleteCar(car.id).then((_) {
                      setState(() {
                        _todosCarros.remove(car);
                        _carrosFiltrados.remove(car);
                      });
                    });
                  },
                );
              },
              itemCount: _carrosFiltrados.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => CarForm(),
                ),
              )
              .then((newCar) => _carregarCarros());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: Color.fromRGBO(0, 48, 92, 1),
      ),
    );
  }
}

class _CarItem extends StatelessWidget {
  final Car car;
  final Function onDelete; // Função callback para exclusão

  _CarItem(this.car, {required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '${car.modelo} - ${car.ano}',
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              car.marca,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              car.cor,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              car.tipo_combustivel,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _showDeleteConfirmationDialog(context);
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Tem certeza que deseja excluir este carro?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                onDelete(); // Chama a função de exclusão
                Navigator.of(context).pop();
              },
              child: Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
