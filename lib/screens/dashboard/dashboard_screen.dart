import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/services/medicine_service.dart';

import '../../bloc/medicine_operation/medicine_operation_bloc.dart';
import '../../repositories/medicine_repository.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final MedicineService _medicineService = MedicineService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => MedicineOperationBloc(
            medicineRepository:
                MedicineRepository(medicineService: _medicineService)),
        child: BlocConsumer<MedicineOperationBloc, MedicineOperationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Column(children: [
                Center(
                  child: Text(
                    "Under Construction",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                )
              ]),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // BlocProvider.of<MedicineOperationBloc>(context)
                  //     .add(AddMedicineReminder());
                },
                child: const Icon(Icons.add),
              ),
            );
          },
        ),
      ),
    );
  }
}
