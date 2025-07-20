import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class CardButton extends StatelessWidget {
  final String title;
  final Color borderColor;
  final double height;
  final double width;
  final void Function()? onTap;
  const CardButton(
      {super.key,
      required this.title,
      required this.borderColor,
      required this.height,
      required this.width,
      this.onTap});

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: borderColor, width: 1.8),
              right: BorderSide(color: borderColor, width: 1.8),
              top: BorderSide(color: borderColor, width: 1.5),
              bottom: BorderSide(color: borderColor, width: 6),
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 25, right: 20, left: 30),
            child: Text(
              title,
              style: TextStyles.textStyle2.copyWith(
                color: AppColors.darkBlue,
                fontSize: screenWidth > 1900 ? 22 : 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
    );
  }
}
