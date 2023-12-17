import 'package:attendance_system/providers/emp_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../widgets/stats_card.dart';

class DataStatsScreen extends StatefulWidget {
  static const routeName = 'data_stata_screen';
  const DataStatsScreen({Key? key}) : super(key: key);

  @override
  State<DataStatsScreen> createState() => _DataStatsScreenState();
}

class _DataStatsScreenState extends State<DataStatsScreen> {
  bool isLoading = true;
  int absentNo = 0;
  int presentNo = 0;
  int totalNo = 0;
  double? absentPercent;
  double? presentPercent;
  void calculatePercent() {
    setState(() {
      absentPercent = (absentNo / totalNo) * 100;
      presentPercent = (presentNo / totalNo) * 100;
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) {
      setState(() {
        totalNo =
            Provider.of<EmProvider>(context, listen: false).employees.length;
        presentNo =
            Provider.of<EmProvider>(context, listen: false).presentEmps.length;
        absentNo = totalNo - presentNo;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    calculatePercent();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Statistics',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Center(
                        child: PieChart(
                          PieChartData(
                            centerSpaceRadius: 35,
                            centerSpaceColor: Colors.white,
                            sections: [
                              PieChartSectionData(
                                value: presentNo.toDouble(),
                                color: Colors.teal,
                                radius: 80,
                                showTitle: true,
                                title:
                                    '${presentPercent!.toStringAsFixed(1)} %',
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PieChartSectionData(
                                value: absentNo.toDouble(),
                                color: Colors.red,
                                radius: 80,
                                showTitle: true,
                                title: '${absentPercent!.toStringAsFixed(1)} %',
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          StatsCard(
                            color: Colors.red,
                            title: 'Absent',
                            value: absentNo,
                          ),
                          StatsCard(
                            color: Colors.teal,
                            title: 'Present',
                            value: presentNo,
                          ),
                          StatsCard(
                            color: Colors.blue,
                            title: 'Total',
                            value: totalNo,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
