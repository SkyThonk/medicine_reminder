import '../models/medicine.dart';
import '../services/medicine_service.dart';

class MedicineRepository {
  final MedicineService _medicineService;

  MedicineRepository({required MedicineService medicineService})
      : _medicineService = medicineService;

  Future<void> addMedicine(Medicine medicine) =>
      _medicineService.addMedicine(medicine);

  Future<List<Medicine>> getMedicines() => _medicineService.getMedicines();
}
