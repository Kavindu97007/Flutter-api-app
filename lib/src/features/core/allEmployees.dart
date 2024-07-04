// all_employees.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/employeeModel.dart';
import '../../common_widgets/employeeCard.dart';
import '../../common_widgets/menu.dart';
import 'package:http/http.dart' as http;

class AllEmployeesPage extends StatefulWidget {
  const AllEmployeesPage({Key? key}) : super(key: key);

  @override
  _AllEmployeesPageState createState() => _AllEmployeesPageState();
}

class _AllEmployeesPageState extends State<AllEmployeesPage> {
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/employee'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        employees = data.map((e) => Employee.fromJson(e)).toList();
      });
    } else {
      // Handle error
      print('Failed to load employees');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Employees'),
        backgroundColor: Colors.green,
      ),
      drawer: MenuDrawer(),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return EmployeeCard(
            employee: employee,
            onEdit: () => editEmployee(employee),
            onDelete: () => deleteEmployee(employee),
          );
        },
      ),
    );
  }

  void editEmployee(Employee employee) {
    // Implement edit functionality
    // Navigate to edit screen or show dialog
  }

  void deleteEmployee(Employee employee) async {
    final response = await http.delete(Uri.parse('http://localhost:5000/api/employee/${employee.id}'));

    if (response.statusCode == 200) {
      // Remove employee locally from the list
      setState(() {
        employees.remove(employee);
      });
      // Show success message or handle as needed
    } else {
      // Handle error
      print('Failed to delete employee');
    }
  }
}
