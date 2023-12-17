import 'package:flutter/Material.dart';

import '../database/sqflite_db.dart';

// EMPLOYEE MODEL.
class Employee {
  int? id;
  String? name;
  String? place;
  num? quantity;
  String? personResponsible;
  String? readingDate;
  String? deviceSignature;
  Employee(
      {this.id,
      this.name,
      this.place,
      this.quantity,
      this.personResponsible,
      this.readingDate,
      this.deviceSignature});
}

// PROVIDER CLASS OF THE EMPLOYEES.
class EmProvider with ChangeNotifier {
  List<Employee> _employees = [];
  List<Employee> get employees {
    return [..._employees];
  }

  List<Employee> get presentEmps {
    List<Employee> emps = [];
    for (Employee emp in employees) {
      if (emp.readingDate != null) {
        emps.add(emp);
      }
    }
    return emps;
  }

// GET THE EMPLOYEE DATA FROM THE DATABASE
  Future fetchEmployees() async {
    List<Employee> fetchedData = [];
    var response = await SQLDB().readData();
    if (response != null) {
      for (Map i in response) {
        fetchedData.add(Employee(
            id: i['id'],
            name: i['name'],
            place: i['place'],
            quantity: i['quantity'],
            personResponsible: i['person_responsible'],
            readingDate: i['reading_date'],
            deviceSignature: i['device_signature']));
      }
      _employees = fetchedData;
      notifyListeners();
    }
  }

// CLEAR THE TABLE OF EMPLOYEES IN THE DATABASE
  Future clearList() async {
    await SQLDB().deleteData().then((_) => _employees.clear());
    notifyListeners();
  }

// TO UPDATE ATTENDANCE STATUS.
  void updateStatus(
      BuildContext context, String? scannedId, String? deviceSignature) {
    Employee? emp;
    emp = employees.firstWhere((element) => element.id == int.parse(scannedId!),
        orElse: (() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Failure',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'This id is not found',
            softWrap: true,
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      throw ('not found');
    }));
    if (emp.readingDate == null) {
      SQLDB()
          .updateData(
              '${DateTime.now()}', deviceSignature!, int.parse(scannedId!))
          .then((value) {
        if (value == 0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Failure',
                style: TextStyle(color: Colors.red),
              ),
              content: const Text(
                'Failed to update attendance status',
                softWrap: true,
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Success',
              style: TextStyle(color: Colors.teal),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Attendance status has been update Successfuly',
                  softWrap: true,
                ),
                TextFormField(
                  decoration: const InputDecoration(prefixText: 'Name:'),
                  initialValue: emp!.name,
                  enabled: false,
                ),
                TextFormField(
                  decoration: const InputDecoration(prefixText: 'Place:'),
                  initialValue: emp.place,
                  enabled: false,
                ),
                TextFormField(
                  decoration: const InputDecoration(prefixText: 'Quantity:'),
                  initialValue: emp.quantity.toString(),
                  enabled: false,
                ),
                TextFormField(
                  decoration: const InputDecoration(prefixText: 'Responsible:'),
                  initialValue: emp.personResponsible,
                  enabled: false,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
      notifyListeners();
    } else if (emp.readingDate != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Alert',
            style: TextStyle(color: Colors.red),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This id is already recorded as attending at ${emp!.readingDate}',
                softWrap: true,
              ),
              TextFormField(
                decoration: const InputDecoration(prefixText: 'Name:'),
                initialValue: emp.name,
                enabled: false,
              ),
              TextFormField(
                decoration: const InputDecoration(prefixText: 'Place:'),
                initialValue: emp.place,
                enabled: false,
              ),
              TextFormField(
                decoration: const InputDecoration(prefixText: 'Quantity:'),
                initialValue: emp.quantity.toString(),
                enabled: false,
              ),
              TextFormField(
                decoration: const InputDecoration(prefixText: 'Responsible:'),
                initialValue: emp.personResponsible,
                enabled: false,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
    notifyListeners();
  }
}
