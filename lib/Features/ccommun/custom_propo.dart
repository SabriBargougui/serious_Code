import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class CustomPropoButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final void Function()? onPressed;
  final double height;
  final double width;
  const CustomPropoButton(
      {super.key,
      required this.title,
      this.icon,
      this.onPressed,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? Icon(icon, size: 28,color: AppColors.darkBlue,) : SizedBox.shrink(),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyles.buttonText.copyWith(color: AppColors.darkBlue),
                ),
              ],
            ),
          ),
        ));
  }
}
