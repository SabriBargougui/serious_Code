import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class StepWidget extends StatelessWidget {
  final String image;
  final String title;
  final String stepNumber;
  final bool isDisabled;
  final double progress;
  final bool isCompleted;
  const StepWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.progress,
      required this.stepNumber,
      required this.isDisabled,
      required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width:screenWidth > 1900  ? 300 : 220,
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width:screenWidth > 1900  ? 120 : 90,
            height: screenWidth > 1900  ? 120 : 90,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: isDisabled
                  ? AppColors.disabledProgress
                  : isCompleted
                      ? AppColors.borderGreenColor
                      : AppColors.progressColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                  isCompleted ? AppColors.greenColor : AppColors.brandBlue),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: isDisabled
                              ? AppColors.disabledProgress
                              : isCompleted
                                  ? AppColors.borderGreenColor
                                  : AppColors.brandBlue,
                          blurRadius: 6,
                          spreadRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                      border: Border.all(
                          color: isCompleted
                              ? AppColors.borderGreenColor
                              : AppColors.brandBlue,
                          width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Center(
                    child: Text(
                      stepNumber,
                      style: TextStyles.textStyle3.copyWith(
                        color: isDisabled
                            ? AppColors.disabledTextColor
                            : isCompleted
                                ? AppColors.greenColor
                                : AppColors.brandBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyles.textStyle3.copyWith(
                      color: isDisabled
                          ? AppColors.disabledTextColor
                          : isCompleted
                              ? AppColors.greenColor
                              : AppColors.brandBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
