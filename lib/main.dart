// ignore_for_file: avoid_print

import 'package:attendance_system/providers/emp_provider.dart';
import 'package:attendance_system/screens/data_stats.dart';
import 'package:attendance_system/screens/emp_list_screen.dart';
import 'package:attendance_system/screens/manage_data.dart';
import 'package:attendance_system/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'CourierPrime',
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF297AAA),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xFF297AAA),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'CourierPrime',
            ),
          ),
        ),
        home: const MyHomePage(),
        routes: {
          MangeDataScreen.routeName: (context) => const MangeDataScreen(),
          EmpListScreen.routeName: (context) => const EmpListScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          DataStatsScreen.routeName: (context) => const DataStatsScreen(),
        },
      ),
    );
  }
}
