import 'package:path/path.dart';
import 'package:projetopersistencia/models/car.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then(
    (dbPath){
    final String path = join(dbPath, 'banco.db');
    return openDatabase(path,version: 1, onCreate: (db, version){
      db.execute(
        'CREATE TABLE cars('
        'id INTEGER PRIMARY KEY, '
        'modelo TEXT, '
        'marca TEXT, '
        'ano INTEGER, '
        'cor TEXT, '
        'tipo_combustivel TEXT); '
      );
    });
  });
}

Future<int> save(Car car) {
  return createDatabase().then(
    (db) {
      final Map<String, dynamic> carMap = Map();
      carMap['modelo'] = car.modelo;
      carMap['marca'] = car.marca;
      carMap['ano'] = car.ano;
      carMap['cor'] = car.cor;
      carMap['tipo_combustivel'] = car.tipo_combustivel;
      return db.insert('cars', carMap);
    }
  );
}

Future<List<Car>> findAll() {
  return createDatabase().then(
    (db) {
      return db.query('cars').then(
        (maps){
          final List<Car> cars = [];
          for(Map<String, dynamic> map in maps){
            final Car car = Car(
              map['id'],
              map['modelo'],
              map['marca'],
              map['ano'],
              map['cor'],
              map['tipo_combustivel']
            );
            cars.add(car);
          }
          return cars;
        },
      );
    },
  );
}

Future<int> deleteCar(int id) {
  return createDatabase().then(
    (db) {
      return db.delete(
        'cars',
        where: 'id = ?',
        whereArgs: [id],
      );
    },
  );
}

Future<List<Car>> findCarsByModel(String model) {
  return createDatabase().then(
    (db) {
      return db.query(
        'cars',
        where: 'modelo LIKE ?',
        whereArgs: ['%$model%'], // Usa o operador LIKE para busca parcial
      ).then(
        (maps) {
          final List<Car> cars = [];
          for (Map<String, dynamic> map in maps) {
            final Car car = Car(
              map['id'],
              map['modelo'],
              map['marca'],
              map['ano'],
              map['cor'],
              map['tipo_combustivel']
            );
            cars.add(car);
          }
          return cars;
        },
      );
    },
  );
}