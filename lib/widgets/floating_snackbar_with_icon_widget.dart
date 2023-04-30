import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloatingSnackbarWithIconWidget {
  showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        content: Row(
          children: [
            SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  "assets/icons/app_logo.svg",
                  fit: BoxFit.contain,
                )),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                // Displaying the message in the snackbar
                msg,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),

        // Setting the duration of the snackbar based on the length of the message
        duration: msg.length > 50
            ? const Duration(seconds: 7)
            : const Duration(seconds: 4),
      ),
    );
  }
}
