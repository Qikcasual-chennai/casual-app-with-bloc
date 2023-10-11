import 'package:casual_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.onTap, required this.text, this.color});

  final String text;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.all(16)
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: Styles.headLineStyle3
            .copyWith(color: color == null ? Colors.white : Colors.black),
      ),
    );
    // return ElevatedButton(
    //   onPressed: onTap,
    //   style: ElevatedButton.styleFrom(
    //       minimumSize: const Size(double.infinity, 50),
    //       backgroundColor: color,
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
    //   child: Text(
    //     text,
    //     style: Styles.headLineStyle3
    //         .copyWith(color: color == null ? Colors.white : Colors.black),
    //   ),
    // );
  }
}
