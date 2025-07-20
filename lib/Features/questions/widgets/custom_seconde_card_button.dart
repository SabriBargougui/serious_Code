import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class CustomSecondeCardButton extends StatelessWidget {
  final String title;
  final Color borderColor;
  final double height;
  final double width;
  final void Function()? onTap;
  final String alphabet;
  const CustomSecondeCardButton(
      {super.key,
      required this.title,
      required this.borderColor,
      required this.height,
      required this.width,
      this.onTap,
      required this.alphabet});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 0, right: 20, left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.lightBlue,
                  child: Text(
                    alphabet,
                    style: TextStyles.textStyle2.copyWith(
                      color: AppColors.brandBlue,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  title,
                  style: TextStyles.textStyle2.copyWith(
                    color: AppColors.darkBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
