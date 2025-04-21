import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('employees');

  Future<void> saveEmployee(String name, String position) async {
    if (name.isEmpty || position.isEmpty) {
      throw Exception("Nama dan posisi tidak boleh kosong");
    }

    try {
      await _dbRef.push().set({
        'name': name,
        'position': position,
      });
    } catch (e) {
      throw Exception("Gagal menyimpan data: $e");
    }
  }
}
