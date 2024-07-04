import 'package:flutter/material.dart';
import 'src/features/core/addEmployee.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Restaurant App',
      home: AddEmployee(),
    ),
  );
}