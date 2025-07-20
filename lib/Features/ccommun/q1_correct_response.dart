import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class Q1CorrectResponse extends StatelessWidget {
  final String textResponse;
  const Q1CorrectResponse({super.key, required this.textResponse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40,right: 40),
      child: Text(
        textResponse,
        style: TextStyles.textStyle1.copyWith(
            color: AppColors.darkBlue, fontSize: 32, fontWeight: FontWeight.w400),
      ),
    );
  }
}
