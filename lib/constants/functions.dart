// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '/providers/emp_provider.dart';

// TO SHOW ALERT WHEN DELETING THE WHOLE TABLE DATA
void showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('DELETE ?!'),
      content: const Text('Do you really want to delete all data ?!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Provider.of<EmProvider>(context, listen: false)
                .clearList()
                .then((_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Database has been cleared'),
                duration: Duration(seconds: 3),
              ));
            });
          },
          child: const Text('YES'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('NO'),
        ),
      ],
    ),
  );
}

// CREATE AN EXCEL SHEET AND  SAVE THE DATA TO IT
Future<void> creatExcel(BuildContext context) async {
  //CREATE A WORKBOOK
  final Workbook workbook = Workbook();
  //CREATE A SHEET
  final Worksheet sheet = workbook.worksheets[0];

  List<Employee> employees =
      Provider.of<EmProvider>(context, listen: false).employees;

  //CREATE THE ROWS OF DATA
  List<ExcelDataRow> dataRows = [];
  for (Employee emp in employees) {
    dataRows.add(
      ExcelDataRow(cells: <ExcelDataCell>[
        ExcelDataCell(columnHeader: 'id', value: emp.id),
        ExcelDataCell(columnHeader: 'name', value: emp.name),
        ExcelDataCell(columnHeader: 'place', value: emp.place),
        ExcelDataCell(columnHeader: 'quantity', value: emp.quantity),
        ExcelDataCell(
            columnHeader: 'person responsible', value: emp.personResponsible),
        ExcelDataCell(columnHeader: 'reading date', value: emp.readingDate),
        ExcelDataCell(
            columnHeader: 'device signature', value: emp.deviceSignature),
      ]),
    );
  }

  sheet.getRangeByName('C1').setText('Report Date');
  sheet.getRangeByName('D1').setText('${DateTime.now()}');
  sheet.getRangeByName('D1:G1').merge();
//WRITING THE DATA ROWS TO THE EXCEL SHEET
  sheet.importData(dataRows, 3, 1);
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();
  // GETTING THE DOCUMENTS DIRECTORY ON DEVICE
  final String path = (await getApplicationDocumentsDirectory()).path;
  final String fileName = '$path/Report.xlsx';
  print(fileName);
  // CREATING A FILE TO EXPORT
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  // OPEN THE FILE FROM OPEN_FILE PACKAGE
  OpenFile.open(fileName);
}

// GETTING THE DEVICE INFO:
Future getDeviceInfo() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String? deviceSignature;
  deviceSignature = _pref.getString('devicesignature');

  if (deviceSignature != null) {
    print('stored device signature: $deviceSignature');
    return deviceSignature;
  } else {
    final _deviceInfo = DeviceInfoPlugin();
    final info = await _deviceInfo.androidInfo;
    print('${info.model}:${info.androidId}');
    _pref.setString('devicesignature', '${info.model}:${info.androidId}');
    deviceSignature = '${info.model}:${info.androidId}';

    return deviceSignature;
  }
}
