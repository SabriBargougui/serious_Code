import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool isHidden;
  const CustomInputField(
      {super.key,
      required this.title,
      this.controller,
      required this.isHidden});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.textStyle3
                .copyWith(color: AppColors.darkBlue, fontSize: 16),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: isHidden,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: AppColors.darkBlue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: AppColors.darkBlue, width: 1.5),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
