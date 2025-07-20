import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';
import 'package:serious_game/core/service/questionaire_controller.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionaireController>();

    return SizedBox(
      width: 230,
      child: Stack(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                color: AppColors.darkBlue,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(32))),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 30,
            child: Text(
              "Score",
              style: TextStyles.textStyle3.copyWith(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 120,
            child: SizedBox(
              height: 50,
              width: 110,
              child: Card(
                color: AppColors.brandBlue,
                child: Center(
                    child: Obx(
                  () => Text(
                    "${controller.score.value}/20",
                    style: TextStyles.textStyle3.copyWith(
                        color: AppColors.yellow,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                )),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: -15,
            top: 15,
            child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(
                  "assets/images/star.png",
                )),
          ),
        ],
      ),
    );
  }
}
