// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLDB {
  Database? _db;

  // CHECK IF THERE IS AN EXISTING DATABASE OR CREATE A NEW ONE
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else {
      return _db;
    }
  }

// INITIALIZING THE DATABASE
  initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'exceldata.db');
    Database database = await openDatabase(path,
        onCreate: onCreate, version: 1, onUpgrade: onUpgrade);
    return database;
  }

// CREATING A TABLE IN THE DATABASE
  void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE employees (id INTEGER NOT NULL PRIMARY KEY, name TEXT, place TEXT, quantity REAL, person_responsible TEXT, reading_date TEXT, device_signature TEXT )');
    print('DATABASE CREATED');
  }

// UPGRADE DATABASE
  onUpgrade(Database db, int oldVersion, int newVersion) {
    print('ONUPGRADE CALLED======================');
  }

// TO FETCH DATA FROM THE TABLE
  Future readData() async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery('SELECT * FROM employees');
    print(response);
    return response;
  }

// TO ADD DATA IN THE TABLE
  Future insertData(int id, String name, String place, num quantity,
      String personResponsible) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(
        "INSERT INTO employees(id, name, place, quantity, person_responsible) VALUES ('$id','$name','$place', '$quantity', '$personResponsible') ");
    return response;
  }

// TO UPDATE DATA IN THE TABLE
  Future updateData(
      String readingDate, String deviceSignature, int scannedId) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(
        "UPDATE 'employees' SET reading_date ='$readingDate' , device_signature = '$deviceSignature' WHERE id = $scannedId");
    print(
        '$response update result ========================================================================== ');
    return response;
  }

// DELETE THE WHOLE TABLE DATA
  Future deleteData() async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete('DELETE FROM employees');
    return response;
  }
}
