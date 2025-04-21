import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key});

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('employees');

  void saveEmployee() {
    String name = nameController.text.trim();
    String position = positionController.text.trim();

    if (name.isNotEmpty && position.isNotEmpty) {
      dbRef.push().set({
        'name': name,
        'position': position,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil disimpan')),
        );
        nameController.clear();
        positionController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Karyawan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: positionController,
              decoration: const InputDecoration(labelText: 'Posisi'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveEmployee,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
