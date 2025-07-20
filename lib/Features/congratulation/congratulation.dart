import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

import '../../core/service/questionaire_controller.dart';
import '../ccommun/custom_button.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionaireController>();

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Opacity(
                opacity: 0.4,
                child: Image.asset("assets/images/congmain.png",
                    fit: BoxFit.cover)),
          ),
          Positioned.fill(
            child: Image.asset("assets/images/cong1.png", fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Image.asset(
              "assets/images/cong2.png",
              width: 200,
            ),
          ),
          Positioned.fill(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15), // optional horizontal padding
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // THIS pushes content to bottom
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    var isMoreThan = controller.score.value >= 17;
                    if (isMoreThan) {
                      return Text(
                        "Congratulation!",
                        style: TextStyles.textStyle1
                            .copyWith(color: AppColors.yellow),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                  SizedBox(height: 20),
                  Text(
                    'Vous avez terminé le Serious Game !',
                    style: TextStyles.textStyle1.copyWith(
                      color: AppColors.darkBlue,
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Obx(() => Text(
                        'Score obtenu : ${controller.score.value}/20',
                        style: TextStyles.textStyle1.copyWith(
                          color: AppColors.darkBlue,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () async {
                      controller.reset(13);
                      context.pushReplacement('/landing');
                    },
                    isDisabled: false,
                    title: "RECOMMENCER",
                    width: 400,
                    height: 75,
                    icon: Image.asset("assets/icons/butonrightpng.png"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
