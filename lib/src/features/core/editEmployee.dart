// edit_employee.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../models/employeeModel.dart'; // Import the Employee model
import 'package:http/http.dart' as http;

import 'allEmployees.dart';

class EditEmployeePage extends StatefulWidget {
  final Employee employee;

  const EditEmployeePage({required this.employee, super.key});

  @override
  _EditEmployeePageState createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.employee.name);
    ageController = TextEditingController(text: widget.employee.age.toString());
    phoneController = TextEditingController(text: widget.employee.phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> saveChanges() async {
    final updatedEmployee = Employee(
      id: widget.employee.id,
      name: nameController.text,
      age: int.tryParse(ageController.text) ?? widget.employee.age,
      phone: phoneController.text,
    );
    final response = await http.put(
        Uri.parse('http://localhost:5000/api/employee/${widget.employee.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedEmployee),
      );
      print(response.body);
      if (response.statusCode == 200) {
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
    

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
        backgroundColor: Colors.green,
      ),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
