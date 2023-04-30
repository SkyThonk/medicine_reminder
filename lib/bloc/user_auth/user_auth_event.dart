part of 'user_auth_bloc.dart';

abstract class UserAuthEvent extends Equatable {
  const UserAuthEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends UserAuthEvent {
  final String email;
  final String password;

  const UserLoginEvent({required this.email, required this.password});
}

class UserSignupEvent extends UserAuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const UserSignupEvent(
      {required this.email,
      required this.password,
      required this.confirmPassword});
}

class UserGoogleSignInEvent extends UserAuthEvent {}
