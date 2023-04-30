import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Should consider to move this file to /lib/widget if will be used outside of /screen/login_signup
// I am not shifting because I not going to use this widget outside of /screen/login_signup as of yet. - Akash
class AppLogoLargeWidget extends StatelessWidget {
  const AppLogoLargeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      height: 84,
      child: SvgPicture.asset("assets/icons/app_logo.svg"),
    );
  }
}
