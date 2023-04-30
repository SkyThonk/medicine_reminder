import 'package:medicine_reminder/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicine_reminder/utils/validator_constants.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final AuthenticationRepository _authenticationRepository;

  UserAuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(UserAuthInitial()) {
    on<UserAuthEvent>((event, emit) async {
      //Event Listner for login user
      if (event is UserLoginEvent) {
        emit(UserAuthLoading());
        if (event.email.isEmpty) {
          emit(const UserAuthFailure(error: 'Please enter email'));
        } else if (event.password.isEmpty) {
          emit(const UserAuthFailure(error: 'Please enter password'));
        } else {
          final success = await _authenticationRepository.signIn(
            email: event.email,
            password: event.password,
          );

          if (success) {
            emit(UserAuthSucess());
          } else {
            emit(const UserAuthFailure(error: 'Invalid email or password'));
          }
        }
      }
      // Event Listner for regestring user
      else if (event is UserSignupEvent) {
        emit(UserAuthLoading());

        if (event.email.isEmpty) {
          emit(const UserAuthFailure(error: 'Please enter email'));
        } else if (event.password.isEmpty || event.confirmPassword.isEmpty) {
          emit(const UserAuthFailure(error: 'Please enter password'));
        } else if (!ValidatorConstants().isValidEmail(event.email)) {
          emit(const UserAuthFailure(error: 'Please enter a valid password.'));
        } else if (!ValidatorConstants().isValidPassword(event.password)) {
          emit(const UserAuthFailure(
              error:
                  'Password must contain at least one uppercase letter, one lowercase letter, one digit, and a minimum length of 8 characters.'));
        } else if (event.password != event.confirmPassword) {
          emit(const UserAuthFailure(error: 'Passwords did not match.'));
        } else {
          final success = await _authenticationRepository.signUp(
            email: event.email,
            password: event.password,
          );

          if (success) {
            emit(UserAuthSucess());
          } else {
            emit(const UserAuthFailure(error: 'Failed to sign up'));
          }
        }
      }

      // Event listener for Google sign-in
      else if (event is UserGoogleSignInEvent) {
        emit(UserGoogleAuthLoading());

        final success = await _authenticationRepository.signInWithGoogle();

        if (success) {
          emit(UserAuthSucess());
        } else {
          emit(const UserAuthFailure(error: 'Failed to sign up'));
        }
      }
    });
  }
}
