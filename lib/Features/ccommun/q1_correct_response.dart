import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class Q1CorrectResponse extends StatelessWidget {
  final String textResponse;
  final bool? isHasImage;

  const Q1CorrectResponse(
      {super.key, required this.textResponse, this.isHasImage});

  @override
  Widget build(BuildContext context) {
    return isHasImage == null || isHasImage == false
        ? Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Text(
              textResponse,
              style: TextStyles.textStyle1.copyWith(
                  color: AppColors.darkBlue,
                  fontSize: 32,
                  fontWeight: FontWeight.w400),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 50),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    textResponse,
                    style: TextStyles.textStyle1.copyWith(
                      color: AppColors.darkBlue,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/foiscorrect.png",
                  width: 300,
                )
              ],
            ),
          );
  }
}
