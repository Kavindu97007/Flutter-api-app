// add_employee.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../common_widgets/menu.dart';
import '../../models/employeeModel.dart';
import 'package:http/http.dart' as http;
import './allEmployees.dart'; // Import AllEmployeesPage

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void postdata() async {
    final String name = nameController.text;
    final int age = int.tryParse(ageController.text) ?? 0;
    final String phone = phoneController.text;

    if (name.isNotEmpty && age > 0 && phone.isNotEmpty) {
      final newEmployee = Employee(
        name: name,
        age: age,
        phone: phone,
      );
      print(newEmployee.phone);

      final response = await http.post(
        Uri.parse('http://localhost:5000/api/employee'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newEmployee),
      );
      print(response.body);
      if (response.statusCode == 201) {
        // Successfully added employee
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllEmployeesPage(),
          ),
        );
      } else {
        // Handle error
        print('Failed to add employee');
      }
    } else {
      // Handle validation error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Registration'),
        backgroundColor: Colors.green,
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        onPressed: postdata,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
