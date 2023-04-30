import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/rounded_wide_button.dart';

class GoogleLoginButtonWidget extends RoundedWideButton {
  const GoogleLoginButtonWidget(
      {super.key, required super.label, required super.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Row(
        children: [
          SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset("assets/icons/google_logo.svg")),
          const Spacer(),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black87),
          ),
          const SizedBox(
            width: 24,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
