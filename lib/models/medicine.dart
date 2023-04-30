import 'package:firebase_database/firebase_database.dart';

class Medicine {
  String? id;
  String name;
  String? description;

  DateTime? reminderTime;

  Medicine({
    required this.name,
    this.description,
    this.reminderTime,
  });

  Medicine.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        name = (snapshot.value as Map<String, dynamic>)['name'],
        description = (snapshot.value as Map<String, dynamic>)['description'],
        reminderTime = DateTime.parse(
            (snapshot.value as Map<String, dynamic>)['reminderTime']);

  toJson() {
    return {
      'name': name,
      'description': description,
      'reminderTime': reminderTime?.toIso8601String(),
    };
  }
}
