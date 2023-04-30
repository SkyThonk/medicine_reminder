import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/repositories/authentication_repository.dart';
import 'package:medicine_reminder/utils/app_routes.dart';
import 'package:medicine_reminder/widgets/floating_snackbar_with_icon_widget.dart';
import 'package:medicine_reminder/widgets/password_textfield.dart';
import 'package:medicine_reminder/widgets/textfield_with_icon_widget.dart';
import 'package:medicine_reminder/widgets/rounded_wide_button.dart';
import '../../bloc/user_auth/user_auth_bloc.dart';
import '../../utils/size_constants.dart';
import 'widgets/app_logo_large_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userConfirmPasswordController =
      TextEditingController();

  void onSignupButtonClick(BuildContext context) {
    BlocProvider.of<UserAuthBloc>(context).add(UserSignupEvent(
        email: _userEmailController.text,
        password: _userPasswordController.text,
        confirmPassword: _userConfirmPasswordController.text));
  }

  void onLoginTextButton() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.login, (route) => false);
  }

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => UserAuthBloc(
            authenticationRepository:
                AuthenticationRepositoryImpl(firebaseAuth: firebaseAuth)),
        child: BlocConsumer<UserAuthBloc, UserAuthState>(
          listener: (context, state) {
            if (state is UserAuthFailure) {
              FloatingSnackbarWithIconWidget().showToast(context, state.error);
            } else if (state is UserAuthSucess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.dashboard, (route) => false);
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(SizeConstants.kSpacingMedium),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AppLogoLargeWidget(),
                        Text(
                          "Signup",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: SizeConstants.kSpacingLarge),
                        TextFieldWithIconWidget(
                          controller: _userEmailController,
                          hinttext: "Email",
                          iconData: Icons.email_outlined,
                        ),
                        SizedBox(height: SizeConstants.kSpacingMedium),
                        PasswordTextField(
                          controller: _userPasswordController,
                          hinttext: "Password",
                        ),
                        SizedBox(height: SizeConstants.kSpacingMedium),
                        PasswordTextField(
                          controller: _userConfirmPasswordController,
                          hinttext: "Confirm Password",
                        ),
                        SizedBox(
                          height: SizeConstants.kSpacingExtraLarge,
                        ),
                        if (state is UserAuthLoading)
                          const CircularProgressIndicator()
                        else
                          RoundedWideButton(
                              label: "Signup",
                              onPressed: () => onSignupButtonClick(context)),
                        SizedBox(height: SizeConstants.kSpacingMedium),
                        TextButton(
                            onPressed: onLoginTextButton,
                            child: const Text("Login"))
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
