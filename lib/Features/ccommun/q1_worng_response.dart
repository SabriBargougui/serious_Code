import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';

class Q1WorngResponse extends StatelessWidget {
  final String textResponse;
  final bool? isHasImage;
  const Q1WorngResponse(
      {super.key, required this.textResponse, this.isHasImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 50, left: 50, bottom: 50),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderRedColor, width: 0.5),
          color: Color(0xFFFFF3CD),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/boul.png"),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: "Voici la bonne réponse :\n",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppColors.darkBlue,
                          fontSize: 28),
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkBlue),
                      text: textResponse,
                    ),
                  ],
                ),
              ),
            ),
            isHasImage != null && isHasImage == true
                ? Image.asset(
                    "assets/images/foiscorrect.png",
                    width: 300,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
