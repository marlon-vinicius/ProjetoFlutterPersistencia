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
  final List<Car> cars = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 48, 92, 1),
          title: const Text(
            "Carros",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        body: FutureBuilder(
          initialData: [],
          future: Future.delayed(Duration(seconds: 2)).then((value) => findAll()),
          builder: (context,snapshot) {


          switch (snapshot.connectionState) {
            case ConnectionState.none:
            break;

            case ConnectionState.waiting: 
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                    Text("Loading")                  
                ],
              )
            );
            break;

            case ConnectionState.active:
            break;

            case ConnectionState.done:
            final List<Car> cars = snapshot.data as List<Car>;
            return ListView.builder(
            itemBuilder: (context, index) {
              final Car
              car = cars[index];

              return _CarItem(car);
            },
            itemCount: cars.length,
            );
            break;      
          }
          return Text("Uknown");

          }          
        ) ,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => CarForm(),
              )
            ).then(
              (newCar) => setState(() { })
            );
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

  _CarItem(this.car);

  @override
  Widget build(BuildContext context) {
    return Card(
              child: ListTile(
                title: Text(
                 car.modelo,
                  style: TextStyle(fontSize: 24),
                ),
                subtitle: Text(car.ano.toString(),
                style: TextStyle(fontSize: 16)),
              ),
            );
  }

}
