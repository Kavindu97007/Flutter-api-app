// employee_model.dart

class Employee {
  final String? id; // Make the id optional as it will be generated by MongoDB
  final String name;
  final int age;
  final String phone;

  Employee({
    this.id, // Update to make id optional
    required this.name,
    required this.age,
    required this.phone,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'], // Use _id from JSON response for MongoDB-generated ID
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
    };
  }
}
