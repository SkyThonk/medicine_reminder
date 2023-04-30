part of 'medicine_operation_bloc.dart';

abstract class MedicineOperationEvent extends Equatable {
  const MedicineOperationEvent();

  @override
  List<Object> get props => [];
}

class AddMedicineReminder extends MedicineOperationEvent {
  final String medicineName;
  final String description;
  final DateTime reminderTime;

  const AddMedicineReminder(
      {required this.medicineName,
      required this.description,
      required this.reminderTime});
}
