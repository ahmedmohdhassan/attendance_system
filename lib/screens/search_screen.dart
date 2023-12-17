import 'package:attendance_system/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/emp_provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  // TO STORE SEARCH RESULTS
  List<Employee> searchResult = [];
  // THE LIST OF EMPLOYEES FROM DATABASE
  List<Employee> empList = [];
  // THIS IS THE SEARCH METHOD.
  void search() {
    if (controller.text.isNotEmpty) {
      setState(() {
        searchResult = empList
            .where((element) => element.name!.contains(controller.text))
            .toList();
      });
    } else {
      setState(() {
        searchResult = [];
      });
    }
  }

  @override
  void initState() {
    // CALL THE LIST OF EMPLOYEES
    Future.delayed(const Duration(milliseconds: 0)).then((_) {
      setState(() {
        empList = Provider.of<EmProvider>(context, listen: false).employees;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomFormField(
                controller: controller,
                textInputAction: TextInputAction.search,
                labelText: 'Search by name ...',
                prefixIcon: const Icon(Icons.search),
                onChanged: (_) {
                  search();
                },
              ),
            ),
            Expanded(
              child: controller.text.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(50),
                      child: Center(
                        child: Text(
                          'Start typing to view search results . . .',
                          softWrap: true,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      itemCount: searchResult.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Material(
                              elevation: 2,
                              child: ListTile(
                                title: Text(searchResult[i].name!),
                                subtitle: Text(searchResult[i].place!),
                                trailing: Text(
                                  searchResult[i].readingDate != null
                                      ? 'حضور'
                                      : 'غياب',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: searchResult[i].readingDate != null
                                        ? Colors.teal
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
