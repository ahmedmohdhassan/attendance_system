import 'package:attendance_system/screens/search_screen.dart';
import 'package:attendance_system/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/emp_provider.dart';

class EmpListScreen extends StatelessWidget {
  static const routeName = 'emp_list_screen';
  const EmpListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data List'),
      ),
      body: FutureBuilder(
          future:
              Provider.of<EmProvider>(context, listen: false).fetchEmployees(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error Fetching Data'),
              );
            }
            return Consumer<EmProvider>(
              builder: ((context, empData, _) => empData.employees.isEmpty
                  ? const Center(
                      child: Text(
                      'No Data To Display . . .',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: OnTapFormField(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(SearchScreen.routeName);
                              },
                              labelText: 'Search by name ...',
                              prefixIconButton: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              itemCount: empData.employees.length,
                              itemBuilder: (context, i) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Material(
                                    elevation: 2,
                                    child: ListTile(
                                      title: Text(empData.employees[i].name!),
                                      subtitle:
                                          Text(empData.employees[i].place!),
                                      trailing: Text(
                                        empData.employees[i].readingDate != null
                                            ? 'حضور'
                                            : 'غياب',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: empData.employees[i]
                                                      .readingDate !=
                                                  null
                                              ? Colors.teal
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
            );
          }),
    );
  }
}
