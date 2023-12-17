import 'dart:convert';

import 'package:excel_to_json/ExcelToJson.dart';
import 'package:flutter/material.dart';
import '../database/sqflite_db.dart';
import '/constants/functions.dart';

class MangeDataScreen extends StatefulWidget {
  static const routeName = 'manage_data_screen';
  const MangeDataScreen({Key? key}) : super(key: key);

  @override
  State<MangeDataScreen> createState() => _MangeDataScreenState();
}

class _MangeDataScreenState extends State<MangeDataScreen> {
  // TO IMPORT DATA FROM EXTERNAL EXCEL SHEET TO THE APP.
  void importData() {
    // CONVERT THE DATA FROM AN EXTERNAL EXCEL SHEET TO JSON
    ExcelToJson().convert().then((value) async {
      if (value != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Data import successful . . .'),
          duration: Duration(seconds: 3),
        ));
      }
      var data = jsonDecode(value!);
      //SAVE THE DATA INTO THE DATABASE
      for (Map i in data) {
        await SQLDB().insertData(i['id'], i['name'], i['place'], i['quantity'],
            i['person_responsible']);
      }
      // READ THE DATA FROM THE DATABASE
      SQLDB().readData();
      // TO REFRESH THE UI AFTER ADDING THE DATA.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Data'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  importData();
                },
                icon: const Icon(
                  Icons.import_export,
                  size: 30,
                ),
                label: const Text(
                  'Import Data',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  creatExcel(context);
                },
                icon: const Icon(
                  Icons.save,
                  size: 30,
                ),
                label: const Text(
                  'Export Data',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showAlert(context);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                ),
                label: const Text(
                  'Delete Data',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
