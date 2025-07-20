import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final double width;
  final double height;
  final bool isDisabled;
  final void Function()? onPressed;
  const CustomButton(
      {super.key,
      required this.title,
      this.icon,
      this.onPressed,
      required this.width,
      required this.height,
      required this.isDisabled});

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              isDisabled ? AppColors.disabledButtonColor : AppColors.yellow),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth > 1900 ?  36 : 20,
                color: isDisabled ? AppColors.disabledText : Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            icon ?? SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
