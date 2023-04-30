part of 'user_auth_bloc.dart';

abstract class UserAuthState extends Equatable {
  const UserAuthState();

  @override
  List<Object> get props => [];
}

class UserAuthInitial extends UserAuthState {}

class UserAuthLoading extends UserAuthState {}

class UserGoogleAuthLoading extends UserAuthState {}

class UserAuthSucess extends UserAuthState {}

class UserAuthFailure extends UserAuthState {
  final String error;

  const UserAuthFailure({required this.error});
}
