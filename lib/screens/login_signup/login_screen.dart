import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicine_reminder/repositories/authentication_repository.dart';

import 'package:medicine_reminder/utils/app_routes.dart';
import 'package:medicine_reminder/widgets/rounded_wide_button.dart';
import '../../bloc/user_auth/user_auth_bloc.dart';
import '../../utils/size_constants.dart';
import '../../widgets/floating_snackbar_with_icon_widget.dart';
import '../../widgets/password_textfield.dart';
import '../../widgets/textfield_with_icon_widget.dart';
import 'widgets/app_logo_large_widget.dart';
import 'widgets/or_with_horizontal_line_widget.dart';
import 'widgets/google_login_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();

  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void onLoginButtonClick(BuildContext context) {
    BlocProvider.of<UserAuthBloc>(context).add(UserLoginEvent(
        email: _userEmailController.text,
        password: _userPasswordController.text));
  }

  void onGoogleLoginButtonClick(BuildContext context) {
    BlocProvider.of<UserAuthBloc>(context).add(UserGoogleSignInEvent());
  }

  void onSignupTextButton() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.signup, (route) => false);
  }

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => UserAuthBloc(
            authenticationRepository: AuthenticationRepositoryImpl(
                firebaseAuth: _firebaseAuth, googleSignIn: _googleSignIn)),
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
                          "Login",
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
                        SizedBox(
                          height: SizeConstants.kSpacingExtraLarge,
                        ),
                        if (state is UserAuthLoading)
                          const CircularProgressIndicator()
                        else
                          RoundedWideButton(
                              label: "Login",
                              onPressed: () => onLoginButtonClick(context)),
                        SizedBox(height: SizeConstants.kSpacingMedium),
                        const OrWithHorizontalLine(),
                        SizedBox(height: SizeConstants.kSpacingMedium),
                        if (state is UserGoogleAuthLoading)
                          const CircularProgressIndicator()
                        else
                          GoogleLoginButtonWidget(
                              label: "Google Login",
                              onPressed: () =>
                                  onGoogleLoginButtonClick(context)),
                        SizedBox(height: SizeConstants.kSpacingMedium),
                        TextButton(
                            onPressed: onSignupTextButton,
                            child: const Text("Signup")),
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
