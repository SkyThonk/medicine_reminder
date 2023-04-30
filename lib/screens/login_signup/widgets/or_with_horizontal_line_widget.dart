import 'package:flutter/material.dart';

class OrWithHorizontalLine extends StatelessWidget {
  const OrWithHorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          thickness: 2,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "OR",
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.grey),
          ),
        ),
        const Expanded(
            child: Divider(
          thickness: 2,
        ))
      ],
    );
  }
}
