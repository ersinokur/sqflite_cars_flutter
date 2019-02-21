import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlfite_cars/models/car.dart';

class DbHelper {
  static Database _db;
  final String tableName = 'Cars';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDescription = 'description';
  final String columnPrice = 'price';
  final String columnImageUrl = 'imageUrl';
  final String dbName = 'Cars2019.db';
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await _initDb();
    return _db;
  }

  _initDb() async {
    io.Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, dbName);
    var myDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myDb;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        "Create table $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT, $columnDescription TEXT, $columnPrice REAL, $columnImageUrl TEXT) ");
  }

  Future<int> deleteCar(int id) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn
          .rawDelete('Delete from $tableName WHERE $columnId = $id');
    });
  }

  Future<int> updateCar(Car car) async {
    var dbClient = await db;
    return dbClient.update(tableName, car.toMap(),
        where: '$columnId =? ', whereArgs: [car.id]);
  }

  Future<int> insertCar(Car car) async {
    var dbClient = await db;
    return dbClient.insert(tableName, car.toMap());
  }

  Future<List<Car>> getCars() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('Select * from $tableName');
    List<Car> cars = List();
    for (var i = 0; i < list.length; i++) {
      cars.add(Car.withId(list[i]['id'], list[i]['title'],
          list[i]['description'], list[i]['price'], list[i]['imageUrl']));
    }
    return cars;
  }
} //
