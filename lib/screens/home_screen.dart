// ignore_for_file: avoid_print

import 'package:attendance_system/constants/functions.dart';
import 'package:attendance_system/providers/emp_provider.dart';
import 'package:attendance_system/screens/data_stats.dart';
import 'package:attendance_system/screens/emp_list_screen.dart';
import 'package:attendance_system/screens/manage_data.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../widgets/home_card_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //  TO ADD SOUND FOR SCANNING
  final AudioPlayer player = AudioPlayer();
  String? scanResult;
  String? deviceSignature;
  bool? isLoading;
  void playsound() async {
    await player.play(AssetSource('scannersound.mp3'));
    print('sound played ****************************************************');
  }

// TO SCAN THE QR CODE
  Future<void> scanQR() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
              '#5779e0', 'Cancel', true, ScanMode.QR)
          .then((barcodeScanRes) {
        if (barcodeScanRes.toString().contains('-')) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to scan Qr code !!!'),
            duration: Duration(seconds: 3),
          ));
        } else {
          playsound();
          setState(() {
            scanResult = barcodeScanRes.toString();
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successful Qr code scan ...'),
            duration: Duration(seconds: 3),
          ));

          print(
              '$scanResult ====================================================');
        }
      });
    } on PlatformException {
      print('Failed to get platform version.');
    }

    if (!mounted) return;
  }

  @override
  void initState() {
    isLoading = true;

    getDeviceInfo().then((value) {
      setState(() {
        deviceSignature = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<EmProvider>(context, listen: false).fetchEmployees();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance System'),
        elevation: 2,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard(
                      icon: Icons.people_alt,
                      text: 'List',
                      color: Colors.deepPurpleAccent,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(EmpListScreen.routeName);
                      },
                    ),
                    const SizedBox(width: 10),
                    HomeCard(
                      icon: Icons.qr_code,
                      text: 'Scan',
                      color: Colors.lightBlue,
                      onTap: () {
                        scanQR().then((_) {
                          if (scanResult != null && deviceSignature != null) {
                            Provider.of<EmProvider>(context, listen: false)
                                .updateStatus(
                                    context, scanResult, deviceSignature);
                          }
                        });
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard(
                      icon: Icons.add_chart,
                      text: 'Data',
                      color: const Color(0xff0040FF),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(DataStatsScreen.routeName);
                      },
                    ),
                    const SizedBox(width: 10),
                    HomeCard(
                      icon: Icons.import_export,
                      text: 'Manage',
                      color: const Color(0xffCE45FF),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(MangeDataScreen.routeName);
                      },
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
