import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicine_reminder/repositories/medicine_repository.dart';

import '../../models/medicine.dart';

part 'medicine_operation_event.dart';
part 'medicine_operation_state.dart';

class MedicineOperationBloc
    extends Bloc<MedicineOperationEvent, MedicineOperationState> {
  final MedicineRepository _medicineRepository;

  MedicineOperationBloc({required MedicineRepository medicineRepository})
      : _medicineRepository = medicineRepository,
        super(MedicineOperationInitial()) {
    // Event handler for add medicine reminder
    on<MedicineOperationEvent>((event, emit) async {
      if (event is AddMedicineReminder) {
        emit(MedicineAddLoading());
        Medicine medicine = Medicine(
          name: event.medicineName,
          description: event.description,
          reminderTime: event.reminderTime,
        );
        try {
          _medicineRepository.addMedicine(medicine);
        } catch (error) {
          emit(MedicineOperatorFailure(error: error.toString()));
        }
      }
    });
  }
}
