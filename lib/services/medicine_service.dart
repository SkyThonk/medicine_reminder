import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/medicine.dart';

class MedicineService {
  final databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addMedicine(Medicine medicine) async {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      await databaseReference
          .child('users/$uid/medicines')
          .push()
          .set(medicine.toJson());
    }
  }

  Future<List<Medicine>> getMedicines() async {
    List<Medicine> medicines = [];
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      await databaseReference
          .child('users/$uid/medicines')
          .once()
          .then((event) {
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic>? map =
              event.snapshot.value as Map<dynamic, dynamic>?;

          if (map != null) {
            map.forEach((key, value) {
              Medicine medicine = Medicine.fromSnapshot(
                value,
              );
              medicine.id = key.toString();
              medicines.add(medicine);
            });
          }
        }
      });
    }
    return medicines;
  }
}
