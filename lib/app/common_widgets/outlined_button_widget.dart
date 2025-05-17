import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final VoidCallback onClick;
  final Widget? child;
  final String? name;

  const OutlinedButtonWidget({
    super.key,
    required this.onClick,
    required this.name,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onClick,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child:
              child ??
              Text(
                name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
        ),
      ),
    );
  }
}
