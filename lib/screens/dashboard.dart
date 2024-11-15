import 'package:flutter/material.dart';
import 'package:projetopersistencia/screens/cars_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 48, 92, 1),
          title: Text(
            "Dashboard",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
              'images/bb.png',
              width: screenWidth,
              fit: BoxFit.cover
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push((MaterialPageRoute(
                    builder: (context) => CarsList(),
                  )));
                },
                child: Container(
                  height: 100,
                  width: 150,
                  color: Color.fromRGBO(0, 48, 92, 1),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.people,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          'Carros',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}
