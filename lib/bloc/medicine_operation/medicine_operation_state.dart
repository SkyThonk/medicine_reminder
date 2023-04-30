part of 'medicine_operation_bloc.dart';

abstract class MedicineOperationState extends Equatable {
  const MedicineOperationState();

  @override
  List<Object> get props => [];
}

class MedicineOperationInitial extends MedicineOperationState {}

class MedicineAddLoading extends MedicineOperationState {}

class GetMedicinesLoading extends MedicineOperationState {}

class MedicineOperatorFailure extends MedicineOperationState {
  final String error;

  const MedicineOperatorFailure({required this.error});
}
