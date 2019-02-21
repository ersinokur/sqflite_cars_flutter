import 'package:flutter/material.dart';
import 'package:sqlfite_cars/models/car.dart';
import 'package:sqlfite_cars/utils/dbHelper.dart';

final dbHelper = DbHelper();
void main() {


  //Car car = Car('Opel', 'Astra 136BG sedan', 300, 'yok');
  //dbHelper.insertCar(car);

  _getList();
  Car carUpdate = Car.withId(1,'opel', 'astra j', 700, 'var');
  dbHelper.updateCar(carUpdate);
  //dbHelper.deleteCar(0);

  _getList();
}

void _getList() async {
  var list = await dbHelper.getCars();
  for (var i = 0; i < list.length; i++) {
    print(
        'ID: ${list[i].id}, ${list[i].title}, ${list[i].description}, ${list[i].price}, ${list[i].imageUrl}');
  }
}
