// edit_employee.dart
import 'package:flutter/material.dart';
import '../../models/employeeModel.dart'; // Import the Employee model

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
    phoneController = TextEditingController(text: widget.employee.phoneNumber);
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void saveChanges() {
    final updatedEmployee = Employee(
      id: widget.employee.id,
      name: nameController.text,
      age: int.tryParse(ageController.text) ?? widget.employee.age,
      phoneNumber: phoneController.text,
    );

    Navigator.pop(context, updatedEmployee);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
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
    );
  }
}
