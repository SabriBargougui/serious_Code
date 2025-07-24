import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:serious_game/Features/ccommun/custom_button.dart';
import 'package:serious_game/Features/ccommun/q1_correct_response.dart';
import 'package:serious_game/Features/ccommun/q1_worng_response.dart';
import 'package:serious_game/Features/questions/model/question_model.dart';
import 'package:serious_game/Features/questions/widgets/card_button.dart';
import 'package:serious_game/Features/questions/widgets/custom_q8.dart';
import 'package:serious_game/Features/questions/widgets/custom_seconde_card_button.dart';
import 'package:serious_game/Features/questions/widgets/custom_simple_button.dart';
import 'package:serious_game/Features/questions/widgets/score_widget.dart';
import 'package:serious_game/Features/questions/widgets/step_card.dart';
import 'package:serious_game/Features/questions/widgets/step_widget.dart';
import 'package:serious_game/Features/questions/widgets/welcome_widget.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';
import 'package:serious_game/core/service/questionaire_controller.dart';
import 'dart:math' as math;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final controller = Get.find<QuestionaireController>();

  @override
  void initState() {
    super.initState();
    controller.init(13);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final PageController _pageController = PageController();

    final List<String> correctSteps = [
      "Deshydratation",
      "Inclusion en paraffine",
      "Coupe",
      "Coloration",
      "Montage"
    ];

    String q1Response = "";
    final List<List<QuestionModel>> _questionsPerPage = [
      [
        QuestionModel(
          correctIndex: [2],
          correctDialog: Q1CorrectResponse(
            textResponse: "Votre observation est juste.",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse:
                "Non, la fiche de demande n’est pas bien remplie, car il y a 3 éléments manquants :\n"
                "1. La date du prélèvement, l’heure exacte du prélèvement et l’heure de mise dans le formol ne sont pas précisées.\n"
                "2. Signes cliniques non précisés.\n"
                "3. Examens complémentaires non mentionnés: coloscopie? TDM?",
          ),
          question:
              "Est-ce que la fiche de demande est bien remplie ? ",
          image: "assets/images/q1.png",
          image2: "assets/images/q1big.png",
          title: "Voici une fiche de demande que vous avez reçu.",
          widget: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Row(
                    children: [
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 1,
                            isMultiple: false),
                        height: 86,
                        width: screenWidth > 1900 ? 340 : 280,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(1)
                            ? AppColors.borderGreenColor
                            : AppColors.disabledProgress,
                        title: "OUI",
                      ),
                      SizedBox(width: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 2,
                            isMultiple: false),
                        height: 86,
                        width: screenWidth > 1900 ? 340 : 280,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(2)
                            ? AppColors.borderRedColor
                            : AppColors.disabledProgress,
                        title: "NON",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  var isNonSelected = controller
                      .getSelectedAnswers(controller.currentQuestionIndex.value)
                      .contains(2);

                  if (isNonSelected) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Justification",
                          style: TextStyles.textStyle1.copyWith(
                            color: AppColors.darkBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenWidth > 1900 ? null : 600,
                          height: screenHeight > 820 ? 200 : 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.brandBlue, width: 0.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Non, la fiche de demande n’est pas bien remplie, car il y’a 3 éléments manquants :",
                                  style: TextStyles.textStyle1.copyWith(
                                    color: AppColors.darkBlue,
                                    fontSize: screenWidth > 1900 ? 19 : 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "1. Date du prélèvement, heure exacte du prélèvement et heure de mise dans  le formol qui ne sont pas précisées.",
                                    style: TextStyles.textStyle1.copyWith(
                                      color: AppColors.darkBlue,
                                      fontSize: screenHeight > 820 ? 19 : 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "2. Signes cliniques non précisés.",
                                    style: TextStyles.textStyle1.copyWith(
                                      color: AppColors.darkBlue,
                                      fontSize: screenHeight > 820 ? 19 : 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "3. Examens complémentaires non mentionnés: coloscopie? TDM?.",
                                    style: TextStyles.textStyle1.copyWith(
                                      color: AppColors.darkBlue,
                                      fontSize: screenHeight > 820 ? 19 : 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
          ),
        ),
        QuestionModel(
          correctIndex: [1],
          correctDialog: Q1CorrectResponse(
            textResponse: "Votre observation est juste.",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse:
                "La quantité du formol doit être idéalement égale à 10 fois le volume du prélèvement ou au moins recouvrir toute la pièce.",
          ),
          question: "Est-ce que la quantité du formol est suffisante ?",
          image: "assets/images/q2.png",
          image2: "",
          title: "Vous avez reçu le flacon comportant le prélèvement",
          widget: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Column(
                    children: [
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 1,
                            isMultiple: false),
                        height: 86,
                        width: 560,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(1)
                            ? AppColors.borderGreenColor
                            : AppColors.disabledProgress,
                        title: "OUI, la quantité de formol est suffisante",
                      ),
                      SizedBox(height: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 2,
                            isMultiple: false),
                        height: 86,
                        width: 560,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(2)
                            ? AppColors.borderRedColor
                            : AppColors.disabledProgress,
                        title: "NON, la quantité de formol est insuffisante.",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          correctIndex: [1],
          correctDialog: Q1CorrectResponse(
            textResponse:
                "Votre observation est juste. Vous avez correctement identifié la situation et appliqué les bonnes pratiques du service d’Anatomie Pathologique.",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse:
                "Un récipient adapté doit permettre une immersion complète du prélèvement dans le formol.",
          ),
          question:
              "Est-ce que le récipient est adapté à la taille  du prélèvement ?",
          image: "assets/images/q3.png",
          image2: "",
          title: "",
          widget: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 1,
                            isMultiple: false),
                        height: 96,
                        width: 560,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(1)
                            ? AppColors.borderGreenColor
                            : AppColors.disabledProgress,
                        title:
                            "OUI, le récipient est adapté à la taille du prélèvement",
                      ),
                      SizedBox(height: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 2,
                            isMultiple: false),
                        height: 96,
                        width: 560,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(2)
                            ? AppColors.borderRedColor
                            : AppColors.disabledProgress,
                        title:
                            "NON, le récipient n’est pas adapté à la taille du prélèvement.",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          question: "Quel est le temps nécessaire pour une bonne fixation ?",
          image: "assets/images/q4.png",
          image2: "",
          title: "",
          correctIndex: [2],
          correctDialog: Q1CorrectResponse(
            textResponse:
                "Votre observation est juste. Vous avez correctement identifié la situation et appliqué les bonnes pratiques du service d’Anatomie Pathologique.",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse:
                "Pour cette pièce opératoire, le temps de fixation idéal est  entre 24 et 72 heures.",
          ),
          widget: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight > 820 ? 50 : 20),
                Obx(
                  () => Column(
                    children: [
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 1,
                            isMultiple: false),
                        height: 86,
                        width: screenWidth > 1900 ? 560 : 400,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(1)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "Inférieur à 24 heures",
                      ),
                      SizedBox(height: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 2,
                            isMultiple: false),
                        height: 86,
                        width: screenWidth > 1900 ? 560 : 400,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(2)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "Entre 24 et 72 heures",
                      ),
                      SizedBox(height: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 3,
                            isMultiple: false),
                        height: 86,
                        width: screenWidth > 1900 ? 560 : 400,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(3)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "Supérieur à 72 heures",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          question:
              "Une fois le prélèvement est bien fixé et la fiche de demande est bien remplie, quelle est l'étape suivante ?",
          image: "",
          image2: "",
          title: "",
          correctIndex: [1],
          correctDialog: Q1CorrectResponse(
            textResponse:
                "Le prélèvement est maintenant prêt à être examiné macroscopiquement. Direction la salle de macroscopie !",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse:
                "Avant de passer à la salle technique, le prélèvement doit d’abord passer par l’étape de macroscopie.",
          ),
          widget: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight > 820 ? 350 : 250),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              child: CardButton(
                                onTap: () => controller.selectAnswer(
                                    controller.currentQuestionIndex.value, 1,
                                    isMultiple: false),
                                height: 86,
                                width: screenWidth > 1900 ? 320 : 250,
                                borderColor: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(1)
                                    ? AppColors.brandBlue
                                    : AppColors.disabledProgress,
                                title: "Salle de macroscopie",
                              ),
                            ),
                            Positioned(
                              top: screenHeight > 820 ? -330 : -180,
                              left: screenWidth > 1900 ? -90 : -20,
                              child: Opacity(
                                opacity: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(1)
                                    ? 1.0
                                    : 0.7,
                                child: Image.asset(
                                  "assets/icons/Salle1.png",
                                  width: screenHeight > 810 ? null : 250,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth > 1900 ? 250 : 150,
                      ),
                      SizedBox(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              child: CardButton(
                                onTap: () => controller.selectAnswer(
                                    controller.currentQuestionIndex.value, 2,
                                    isMultiple: false),
                                height: 86,
                                width: screenWidth > 1900 ? 320 : 250,
                                borderColor: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(2)
                                    ? AppColors.brandBlue
                                    : AppColors.disabledProgress,
                                title: "Bureau du médecin",
                              ),
                            ),
                            Positioned(
                              top: screenHeight > 820 ? -330 : -180,
                              left: screenWidth > 1900 ? -90 : -20,
                              child: Opacity(
                                opacity: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(2)
                                    ? 1.0
                                    : 0.7,
                                child: Image.asset(
                                  "assets/icons/Salle2.png",
                                  width: screenHeight > 810 ? null : 250,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth > 1900 ? 250 : 150,
                      ),
                      SizedBox(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              child: CardButton(
                                onTap: () => controller.selectAnswer(
                                    controller.currentQuestionIndex.value, 3,
                                    isMultiple: false),
                                height: 86,
                                width: screenWidth > 1900 ? 320 : 250,
                                borderColor: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(3)
                                    ? AppColors.brandBlue
                                    : AppColors.disabledProgress,
                                title: "Salle technique",
                              ),
                            ),
                            Positioned(
                              top: screenHeight > 820 ? -330 : -180,
                              left: screenWidth > 1900 ? -90 : -20,
                              child: Opacity(
                                opacity: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(3)
                                    ? 1.0
                                    : 0.7,
                                child: Image.asset(
                                  "assets/icons/Salle3.png",
                                  width: screenHeight > 810 ? null : 250,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          correctIndex: [2],
          correctDialog: Q1CorrectResponse(
            textResponse:
                "Votre estimation de la longueur du côlon est correcte. Une bonne évaluation macroscopique est essentielle pour l’interprétation histologique.",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse: "La longueur du côlon est de 10 cm",
          ),
          question: "Longueur du côlon",
          image: "assets/images/q5.png",
          image2: "assets/images/q5big.png",
          title: "Décrire l’aspect macroscopique de cette pièce ?.",
          widget: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Obx(
                  () => Row(
                    children: [
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 1),
                        height: 86,
                        width: 130,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(1)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "5 cm",
                      ),
                      SizedBox(width: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 2,
                            isMultiple: false),
                        height: 86,
                        width: 130,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(2)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "10 cm",
                      ),
                      SizedBox(width: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 3,
                            isMultiple: false),
                        height: 86,
                        width: 130,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(3)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "15 cm",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          correctIndex: [2],
          correctDialog: Q1CorrectResponse(
            textResponse:
                "La taille de la tumeur est bien de 3 cm, selon l’image et l’échelle fournie.",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse: "La tumeur mesure 3 cm. Vous pouvez mesurer de \n"
                " façon précise la tumeur en vous aidant de la règle.",
          ),
          question: "Taille de la tumeur",
          image: "assets/images/q6.png",
          image2: "assets/images/q6big.png",
          title: "Décrire l’aspect macroscopique de cette pièce ?.",
          widget: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Obx(
                  () => Row(
                    children: [
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 1,
                            isMultiple: false),
                        height: 86,
                        width: 130,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(1)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "1 cm",
                      ),
                      SizedBox(width: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 2,
                            isMultiple: false),
                        height: 86,
                        width: 130,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(2)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "3 cm",
                      ),
                      SizedBox(width: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 3,
                            isMultiple: false),
                        height: 86,
                        width: 130,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(3)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "5 cm",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          correctIndex: [3],
          correctDialog: Q1CorrectResponse(
            textResponse:
                "Il s'agit d'une tumeur ulcèro-bourgeonnante en lobe d'oreille. En périphérie, la tumeur est bourgeonnante et elle est ulcérée au centre.",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse:
                "La tumeur présentée est d’aspect ulcèro-bourgeonnante,\n"
                "observez son aspect bourgeonnant en périphérie et son centre qui est ulcéré.",
          ),
          question: "Aspect macroscopique de la tumeur",
          image: "assets/images/q7.png",
          image2: "",
          title: "Décrire l’aspect macroscopique de cette pièce ?.",
          widget: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Obx(
                  () => Row(
                    children: [
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 1,
                            isMultiple: false),
                        height: screenHeight > 800 ? 86 : 70,
                        width: screenWidth > 1900 ? 250 : 220,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(1)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "Tumeur infiltrante",
                      ),
                      SizedBox(width: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 2,
                            isMultiple: false),
                        height: screenHeight > 800 ? 86 : 70,
                        width: screenWidth > 1900 ? 250 : 220,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(2)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "Tumeur végétante",
                      ),
                      SizedBox(width: 35),
                      CardButton(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 3,
                            isMultiple: false),
                        height: screenHeight > 800 ? 86 : 70,
                        width: screenWidth > 1900 ? 250 : 220,
                        borderColor: controller
                                .getSelectedAnswers(
                                    controller.currentQuestionIndex.value)
                                .contains(3)
                            ? AppColors.brandBlue
                            : AppColors.disabledProgress,
                        title: "Tumeur ulcéro-bourgeonnante",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          correctIndex: [1, 2, 3, 6],
          correctDialog: Q1CorrectResponse(
            isHasImage: true,
            textResponse: "Les prélèvements à réaliser sur cette pièce :\n \n"
                "1. Prélèvement des limites chirurgicales : limites saines/tumorales \n"
                "2. Prélèvement de la tumeur \n"
                "3. Curage ganglionnaire à la recherche d’éventuelles métastases ganglionnaires.",
          ),
          wrongDialog: Q1WorngResponse(
            isHasImage: true,
            textResponse: "Les prélèvements à réaliser sur cette pièce :\n"
                "1. Prélèvement des limites chirurgicales : limites saines/tumorales\n"
                "2. Prélèvement de la tumeur\n"
                "3. Curage ganglionnaire à la recherche d’éventuelles métastases ganglionnaires.",
          ),
          question:
              "Identifier les 3 principaux prélèvements à réaliser sur cette pièce ?",
          image: "",
          image2: "",
          title: "",
          widget: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/regles.png",
                    ),
                    const SizedBox(width: 50),
                    Obx(() {
                      final selected = controller.getSelectedAnswers(
                          controller.currentQuestionIndex.value);
                      final orderMap = controller.selectionOrders[
                              controller.currentQuestionIndex.value] ??
                          {};

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset("assets/images/fois.png"),
                          for (final container in controller.containers)
                            Positioned(
                              left: container.left,
                              top: container.top,
                              right: container.right,
                              bottom: container.bottom,
                              child: CustomQ8(
                                imagePath: controller
                                        .overriddenImages[container.index] ??
                                    container.imagePath,
                                isSelected: selected.contains(container.index),
                                width: 210,
                                heigh: 210,
                                onTap: () {
                                  controller.toggleAnswerWithOrder(
                                    controller.currentQuestionIndex.value,
                                    container.index,
                                  );
                                },
                                number: (container.imagePath ==
                                            "assets/images/container2.png" ||
                                        container.imagePath ==
                                            "assets/images/container3.png")
                                    ? '1'
                                    : (orderMap[container.index]?.toString() ??
                                        ''),
                                top: -20,
                                left: container.index == 4 ? 70 : 100,
                              ),
                            ),
                        ],
                      );
                    }),
                    const SizedBox(width: 50),
                    Image.asset("assets/images/lame.png"),
                  ],
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          question:
              "Une fois l'étape de macroscopie terminée, c’est-à-dire après avoir décrit et découpé le prélèvement, quelle est l'étape suivante ?",
          image: "",
          image2: "",
          title: "",
          correctIndex: [2],
          correctDialog: Q1CorrectResponse(
            textResponse:
                "Après la macroscopie, les prélèvements doivent subir les différentes étapes techniques pour avoir une lame lisible  au microscope.",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse:
                "Le prélèvement doit d’abord subir les différentes étapes techniques avant la lecture au microscope.",
          ),
          widget: Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight > 820 ? 350 : 250),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              child: CardButton(
                                onTap: () => controller.selectAnswer(
                                    controller.currentQuestionIndex.value, 1,
                                    isMultiple: false),
                                height: 86,
                                width: 320,
                                borderColor: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(1)
                                    ? AppColors.brandBlue
                                    : AppColors.disabledProgress,
                                title: "Bureau du médecin",
                              ),
                            ),
                            Positioned(
                              top: screenHeight > 820 ? -310 : -180,
                              left: screenWidth > 1900 ? -90 : -20,
                              child: Opacity(
                                opacity: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(1)
                                    ? 1.0
                                    : 0.7,
                                child: Image.asset(
                                  "assets/icons/Salle2.png",
                                  width: screenWidth > 1900 ? null : 250,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth > 1900 ? 100 : 150),
                      SizedBox(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              child: CardButton(
                                onTap: () => controller.selectAnswer(
                                    controller.currentQuestionIndex.value, 2,
                                    isMultiple: false),
                                height: 86,
                                width: 320,
                                borderColor: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(2)
                                    ? AppColors.brandBlue
                                    : AppColors.disabledProgress,
                                title: "Salle technique",
                              ),
                            ),
                            Positioned(
                              top: screenHeight > 820 ? -330 : -180,
                              left: screenWidth > 1900 ? -90 : -20,
                              child: Opacity(
                                opacity: controller
                                        .getSelectedAnswers(controller
                                            .currentQuestionIndex.value)
                                        .contains(2)
                                    ? 1.0
                                    : 0.7,
                                child: Image.asset(
                                  "assets/icons/Salle3.png",
                                  width: screenWidth > 1900 ? null : 250,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          question: "",
          image: "",
          image2: "",
          title: "",
          correctIndex: [], // Not used for this one
          correctIndices: [
            0,
            1,
            2,
            3,
            4
          ], // Order: Déshydratation → Inclusion en paraffine → Coupe → Coloration → Montage
          correctDialog: Q1CorrectResponse(
            textResponse:
                "Vous avez correctement ordonné les étapes techniques :\n"
                "1. Déshydratation\n"
                "2. Inclusion en paraffine\n"
                "3. Coupe\n"
                "4. Coloration\n"
                "5. Montage",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse: "1. Déshydratation\n"
                "2. Inclusion en paraffine\n"
                "3. Coupe\n"
                "4. Coloration\n"
                "5. Montage",
          ),
          widget: SizedBox(
            height: 550,
            width: screenWidth - 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  top: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    child: Image.asset(
                      "assets/images/landref.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  right: screenWidth * 0.05,
                  bottom: 0,
                  child: Image.asset(
                    "assets/images/doc2.png",
                    height: screenHeight > 820
                        ? screenHeight * 0.35
                        : screenHeight * 0.50,
                  ),
                ),

                /// Déshydratation (index = 0)
                Positioned(
                  right: screenWidth * 0.3,
                  top: screenHeight > 820
                      ? screenHeight * 0.1
                      : screenHeight * 0.2,
                  child: Obx(() {
                    final questionIndex = controller.currentQuestionIndex.value;
                    final selected = controller.selectedAnswers[questionIndex];
                    final isSelected = selected.contains(0);
                    final stepNumber =
                        isSelected ? (selected.indexOf(0) + 1).toString() : "";
                    return CustomSimpleButton(
                      onPressed: () => controller.selectAnswer(questionIndex, 0,
                          isMultiple: true),
                      title: "Déshydratation",
                      number: stepNumber,
                      isSelected: isSelected,
                      width: screenWidth * 0.18,
                      heigh: screenHeight * 0.08,
                    );
                  }),
                ),

                /// Inclusion en paraffine (index = 1)
                Positioned(
                  left: screenWidth > 1900
                      ? screenWidth * 0.26
                      : screenWidth * 0.18,
                  top: screenHeight > 820
                      ? screenHeight * 0.1
                      : screenHeight * 0.2,
                  child: Obx(() {
                    final questionIndex = controller.currentQuestionIndex.value;
                    final selected = controller.selectedAnswers[questionIndex];
                    final isSelected = selected.contains(1);
                    final stepNumber =
                        isSelected ? (selected.indexOf(1) + 1).toString() : "";
                    return CustomSimpleButton(
                      onPressed: () => controller.selectAnswer(questionIndex, 1,
                          isMultiple: true),
                      title: "Inclusion en paraffine",
                      number: stepNumber,
                      isSelected: isSelected,
                      width: screenWidth > 1900
                          ? screenWidth * 0.16
                          : (screenWidth * 0.15) + 70,
                      heigh: screenHeight * 0.06,
                    );
                  }),
                ),

                /// Coupe (index = 2)
                Positioned(
                  left: screenWidth > 1900
                      ? screenWidth * 0.10
                      : screenWidth * 0.08,
                  top: screenHeight > 820
                      ? screenHeight * 0.15
                      : screenHeight * 0.2,
                  child: Obx(() {
                    final questionIndex = controller.currentQuestionIndex.value;
                    final selected = controller.selectedAnswers[questionIndex];
                    final isSelected = selected.contains(2);
                    final stepNumber =
                        isSelected ? (selected.indexOf(2) + 1).toString() : "";
                    return CustomSimpleButton(
                      onPressed: () => controller.selectAnswer(questionIndex, 2,
                          isMultiple: true),
                      title: "Coupe",
                      number: stepNumber,
                      isSelected: isSelected,
                      width: screenWidth * 0.1,
                      heigh: screenHeight * 0.07,
                    );
                  }),
                ),

                /// Montage (index = 4)
                Positioned(
                  right: screenWidth * 0.5,
                  top: screenHeight > 820
                      ? screenHeight * 0.02
                      : screenHeight * 0.1,
                  child: Obx(() {
                    final questionIndex = controller.currentQuestionIndex.value;
                    final selected = controller.selectedAnswers[questionIndex];
                    final isSelected = selected.contains(4);
                    final stepNumber =
                        isSelected ? (selected.indexOf(4) + 1).toString() : "";
                    return CustomSimpleButton(
                      onPressed: () => controller.selectAnswer(questionIndex, 4,
                          isMultiple: true),
                      title: "Montage",
                      number: stepNumber,
                      isSelected: isSelected,
                      width: screenWidth * 0.11,
                      heigh: screenHeight * 0.08,
                    );
                  }),
                ),

                /// Coloration (index = 3)
                Positioned(
                  right: screenWidth > 1900
                      ? screenWidth * 0.12
                      : screenWidth * 0.04,
                  top: screenHeight > 820
                      ? screenHeight * 0.15
                      : screenHeight * 0.23,
                  child: Obx(() {
                    final questionIndex = controller.currentQuestionIndex.value;
                    final selected = controller.selectedAnswers[questionIndex];
                    final isSelected = selected.contains(3);
                    final stepNumber =
                        isSelected ? (selected.indexOf(3) + 1).toString() : "";
                    return CustomSimpleButton(
                      onPressed: () => controller.selectAnswer(questionIndex, 3,
                          isMultiple: true),
                      title: "Coloration",
                      number: stepNumber,
                      isSelected: isSelected,
                      width: screenWidth * 0.13,
                      heigh: screenHeight * 0.08,
                    );
                  }),
                ),
                Positioned(
                  top: screenHeight > 820 ? -80 : -80,
                  left: 150,
                  child: SizedBox(
                    width: screenWidth > 1900
                        ? screenWidth * 0.7
                        : screenWidth * 0.7,
                    child: Text(
                      "Quelles sont les différentes étapes techniques que vont subir les prélèvements ?",
                      style: TextStyles.textStyle2.copyWith(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth > 1900 ? 42 : 28,
                      ),
                      softWrap: true,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        QuestionModel(
          question: "",
          image: "",
          image2: "",
          title: "",
          correctIndex: [1],
          correctDialog: Q1CorrectResponse(
            textResponse: "",
          ),
          wrongDialog: Q1WorngResponse(
            textResponse: "",
          ),
          widget: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Obx(() {
                      var isSelected = controller
                          .getSelectedAnswers(
                              controller.currentQuestionIndex.value)
                          .contains(1);
                      return InkWell(
                        onTap: () => controller.selectAnswer(
                            controller.currentQuestionIndex.value, 1,
                            isMultiple: false),
                        child: Opacity(
                          opacity: isSelected ? 1 : 1,
                          child: Image.asset("assets/images/Salle4.png"),
                        ),
                      );
                    }),
                    SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text:
                                "Les prélèvements ont été fixés, découpés, inclus\n"
                                "en paraffine, coupés et colorés.\n"
                                "Les lames sont maintenant prêtes à être analysées au microscope.",
                            style: TextStyles.textStyle3.copyWith(
                              color: AppColors.darkBlue,
                              fontSize: screenWidth > 1900 ? 30 : 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: screenWidth > 1900 ? 800 : 500,
                          child: Text(
                            "Prochaine étape : Bureau du médecin pour l’interprétation et le diagnostic final.",
                            style: TextStyles.textStyle3.copyWith(
                              color: AppColors.brandBlue,
                              fontSize: screenWidth > 1900 ? 36 : 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        QuestionModel(
          question: "Quel est votre diagnostic histologique ?",
          image: "",
          image2: "",
          title: "",
          correctIndex: [5],
          correctDialog: Q1CorrectResponse(
            textResponse:
                "Votre réponse est correcte : Adénocarcinome.Vous avez bien su interpréter les aspects histologiques : L’architecture glandulaire de la prolifération carcinomateuse a permis de retenir le diagnostic d’adénocarcinome.",
          ),
          wrongDialog: Q1WorngResponse(
              textResponse:
                  "Il s'agit plutôt d'un adénocarcinome car présence de structures glandulaires."),
          widget: Padding(
            padding: const EdgeInsets.only(left: 40, top: 20),
            child: Row(
              children: [
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CustomSecondeCardButton(
                              onTap: () => controller.selectAnswer(
                                controller.currentQuestionIndex.value,
                                1,
                                isMultiple: false,
                              ),
                              height: 70,
                              width: 400,
                              borderColor: controller
                                      .getSelectedAnswers(
                                          controller.currentQuestionIndex.value)
                                      .contains(1)
                                  ? AppColors.brandBlue
                                  : AppColors.disabledProgress,
                              title: "Lymphome",
                              alphabet: "A",
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomSecondeCardButton(
                              onTap: () => controller.selectAnswer(
                                  controller.currentQuestionIndex.value, 2,
                                  isMultiple: false),
                              height: 70,
                              width: 420,
                              borderColor: controller
                                      .getSelectedAnswers(
                                          controller.currentQuestionIndex.value)
                                      .contains(2)
                                  ? AppColors.brandBlue
                                  : AppColors.disabledProgress,
                              title: "Sarcome",
                              alphabet: "B",
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomSecondeCardButton(
                              onTap: () => controller.selectAnswer(
                                  controller.currentQuestionIndex.value, 3,
                                  isMultiple: false),
                              height: 70,
                              width: 420,
                              borderColor: controller
                                      .getSelectedAnswers(
                                          controller.currentQuestionIndex.value)
                                      .contains(3)
                                  ? AppColors.brandBlue
                                  : AppColors.disabledProgress,
                              title: "Carcinome épidermoïde",
                              alphabet: "C",
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomSecondeCardButton(
                              onTap: () => controller.selectAnswer(
                                  controller.currentQuestionIndex.value, 4,
                                  isMultiple: false),
                              height: 70,
                              width: 420,
                              borderColor: controller
                                      .getSelectedAnswers(
                                          controller.currentQuestionIndex.value)
                                      .contains(4)
                                  ? AppColors.brandBlue
                                  : AppColors.disabledProgress,
                              title: "Carcinome neuro-endocrine",
                              alphabet: "D",
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomSecondeCardButton(
                              onTap: () => controller.selectAnswer(
                                  controller.currentQuestionIndex.value, 5,
                                  isMultiple: false),
                              height: 70,
                              width: 420,
                              borderColor: controller
                                      .getSelectedAnswers(
                                          controller.currentQuestionIndex.value)
                                      .contains(5)
                                  ? AppColors.brandBlue
                                  : AppColors.disabledProgress,
                              title: "Adénocarcinome",
                              alphabet: "E",
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth > 1900 ? 580 : 350,
                        ),
                        SizedBox(
                          width: screenWidth > 1900 ? 600 : 600,
                          height: screenHeight > 820 ? 500 : 500,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: screenHeight > 820 ? 70 : 70,
                                child: Image.asset("assets/images/finalq1.png",
                                    width: screenWidth > 1900 ? null : null),
                              ),
                              Positioned(
                                top: screenHeight > 820 ? 30 : 30,
                                left: screenWidth > 1900 ? -120 : -120,
                                child: Image.asset("assets/images/finalq3.png",
                                    width: screenWidth > 1900 ? null : null),
                              ),
                              Positioned(
                                left: screenWidth > 1900 ? -370 : -370,
                                bottom: screenHeight > 820 ? 15 : 15,
                                child: Image.asset("assets/images/finalq2.png",
                                    width: screenWidth > 1900 ? null : null),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    ];
    void nextPage() {
      if (controller.currentPage.value == 0) {
        // Welcome screen → go to first questions page
        setState(() {
          controller.currentPage.value++;
          controller.currentQuestionIndex.value = 0;
        });
        _pageController.animateToPage(
          controller.currentPage.value,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        return;
      }

      final int questionPageIndex = controller.currentPage.value - 1;
      final totalQuestions = _questionsPerPage[questionPageIndex].length;

      if (controller.currentQuestionIndex.value < totalQuestions - 1) {
        setState(() {
          controller.currentQuestionIndex.value++;
        });
      } else {
        if (controller.currentPage.value < _questionsPerPage.length) {
          setState(() {
            controller.currentPage.value++;
            controller.currentQuestionIndex.value = 0;
          });
          _pageController.animateToPage(
            controller.currentPage.value,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    }

    void previousPage() {
      // Don't go back if on the welcome screen
      if (controller.currentPage.value == 0) return;

      final questionPageIndex = controller.currentPage.value - 1;

      if (controller.currentQuestionIndex.value > 0) {
        // Go to previous question on same page
        setState(() {
          controller.currentQuestionIndex.value--;
        });
      } else {
        // Safe check for previous page questions
        final prevPageIndex = controller.currentPage.value -
            2; // <- subtract 2 to access previous page's question list

        if (prevPageIndex >= 0 && prevPageIndex < _questionsPerPage.length) {
          setState(() {
            controller.currentPage.value--;
            controller.currentQuestionIndex.value =
                _questionsPerPage[prevPageIndex].length - 1;
          });
        } else {
          // Going back to welcome screen (no questions)
          setState(() {
            controller.currentPage.value--;
            controller.currentQuestionIndex.value = 0;
          });
        }

        _pageController.animateToPage(
          controller.currentPage.value,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    void showWrongAnswerDialog(
        BuildContext context,
        Widget widget,
        String title,
        bool correct,
        double height,
        double width,
        bool isLastQuestion) {
      showDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: correct == true
                              ? AppColors.greenColor
                              : AppColors.borderRedColor,
                          width: 0.7),
                      right: BorderSide(
                          color: correct == true
                              ? AppColors.greenColor
                              : AppColors.borderRedColor,
                          width: 0.7),
                      top: BorderSide(
                          color: correct == true
                              ? AppColors.greenColor
                              : AppColors.borderRedColor,
                          width: 0.7),
                      bottom: BorderSide(
                          color: correct == true
                              ? AppColors.greenColor
                              : AppColors.borderRedColor,
                          width: 14),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color:
                              correct == true ? Colors.green : Colors.redAccent,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20),
                      widget,
                      SizedBox(height: 24),
                      SizedBox(
                        width: 120,
                        height: 76,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            if (isLastQuestion) {
                              context.push('/congrat');
                            } else {
                              nextPage();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFC107),
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            elevation: 2,
                          ),
                          child: Text(
                            "OK",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkBlue,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Red cross icon
                Positioned(
                    top: -70,
                    left: 0,
                    right: 0,
                    child: correct
                        ? Image.asset(
                            "assets/images/right.png",
                            width: 150,
                            height: 150,
                          )
                        : Image.asset(
                            "assets/images/false.png",
                            width: 150,
                            height: 150,
                          )),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(alignment: Alignment.topRight, child: ScoreWidget()),
            Positioned(
              child: PageView(
                controller: _pageController,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 170),
                    child: SizedBox(
                      child: WelcomeWidget(),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 170),
                    child: controller.currentPage.value == 0
                        ? const SizedBox()
                        : Builder(
                            builder: (context) {
                              final questionPageIndex =
                                  controller.currentPage.value - 1;
                              final currentQuestion =
                                  _questionsPerPage[questionPageIndex]
                                      [controller.currentQuestionIndex.value];
                              return StepCard(
                                ishasBigImage: controller
                                            .currentQuestionIndex.value ==
                                        10 ||
                                    controller.currentQuestionIndex.value == 11,
                                questionWidget: controller
                                            .currentQuestionIndex.value ==
                                        5
                                    ? Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                AppColors.lightBlue,
                                            child: Center(
                                              child: Text(
                                                "1",
                                                style: TextStyles.textStyle3
                                                    .copyWith(
                                                        color:
                                                            AppColors.darkBlue,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            currentQuestion.question,
                                            style:
                                                TextStyles.textStyle2.copyWith(
                                              color: AppColors.darkBlue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 42,
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    : controller.currentQuestionIndex.value == 6
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: AppColors
                                                        .borderGreenColor,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    "Longueur du côlon",
                                                    style: TextStyles.textStyle2
                                                        .copyWith(
                                                      color: AppColors.darkBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          screenWidth > 1900
                                                              ? 42
                                                              : 26,
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  CardButton(
                                                    height: 86,
                                                    width: 130,
                                                    borderColor: AppColors
                                                        .disabledProgress,
                                                    title: "5 cm",
                                                  ),
                                                  SizedBox(width: 35),
                                                  CardButton(
                                                    height: 86,
                                                    width: 130,
                                                    borderColor:
                                                        AppColors.greenColor,
                                                    title: "10 cm",
                                                  ),
                                                  SizedBox(width: 35),
                                                  CardButton(
                                                    height: 86,
                                                    width: 130,
                                                    borderColor: AppColors
                                                        .disabledProgress,
                                                    title: "15 cm",
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.lightBlue,
                                                    child: Center(
                                                      child: Text(
                                                        "2",
                                                        style: TextStyles
                                                            .textStyle3
                                                            .copyWith(
                                                                color: AppColors
                                                                    .darkBlue,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    currentQuestion.question,
                                                    style: TextStyles.textStyle2
                                                        .copyWith(
                                                      color: AppColors.darkBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 42,
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        : controller.currentQuestionIndex
                                                    .value ==
                                                7
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: AppColors
                                                            .borderGreenColor,
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        )),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        "Longueur du côlon",
                                                        style: TextStyles
                                                            .textStyle2
                                                            .copyWith(
                                                          color: AppColors
                                                              .darkBlue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              screenWidth > 1900
                                                                  ? 42
                                                                  : 26,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      CardButton(
                                                        height: 86,
                                                        width: 130,
                                                        borderColor: AppColors
                                                            .disabledProgress,
                                                        title: "5 cm",
                                                      ),
                                                      SizedBox(width: 35),
                                                      CardButton(
                                                        height: 86,
                                                        width: 130,
                                                        borderColor: AppColors
                                                            .greenColor,
                                                        title: "10 cm",
                                                      ),
                                                      SizedBox(width: 35),
                                                      CardButton(
                                                        height: 86,
                                                        width: 130,
                                                        borderColor: AppColors
                                                            .disabledProgress,
                                                        title: "15 cm",
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: AppColors
                                                            .borderGreenColor,
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        )),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        "Taille de la tumeur",
                                                        style: TextStyles
                                                            .textStyle2
                                                            .copyWith(
                                                          color: AppColors
                                                              .darkBlue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              screenWidth > 1900
                                                                  ? 42
                                                                  : 26,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      CardButton(
                                                        height: 86,
                                                        width: 130,
                                                        borderColor: AppColors
                                                            .disabledProgress,
                                                        title: "1 cm",
                                                      ),
                                                      SizedBox(width: 35),
                                                      CardButton(
                                                        height: 86,
                                                        width: 130,
                                                        borderColor: AppColors
                                                            .greenColor,
                                                        title: "3 cm",
                                                      ),
                                                      SizedBox(width: 35),
                                                      CardButton(
                                                        height: 86,
                                                        width: 130,
                                                        borderColor: AppColors
                                                            .disabledProgress,
                                                        title: "5 cm",
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            AppColors.lightBlue,
                                                        child: Center(
                                                          child: Text(
                                                            "3",
                                                            style: TextStyles
                                                                .textStyle3
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .darkBlue,
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        currentQuestion
                                                            .question,
                                                        style: TextStyles
                                                            .textStyle2
                                                            .copyWith(
                                                          color: AppColors
                                                              .darkBlue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              screenWidth > 1900
                                                                  ? 42
                                                                  : 26,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            : null,
                                isHasResizeImlage:
                                    currentQuestion.image2 != "" ? true : false,
                                title: currentQuestion.title ?? "",
                                question: currentQuestion.question,
                                image: currentQuestion.image,
                                image2: currentQuestion.image2,
                                widget:
                                    currentQuestion.widget ?? SizedBox.shrink(),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 60,
              child: Container(
                height: 120,
                width: screenWidth,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 20,
                      right: 80,
                      bottom: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 150, right: screenWidth > 1900 ? 350 : 200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              final currentIndex =
                                  controller.currentQuestionIndex.value;

                              return StepWidget(
                                isCompleted:
                                    controller.isStepCompleted(1, currentIndex),
                                isDisabled: false,
                                image:
                                    controller.isStepCompleted(1, currentIndex)
                                        ? 'assets/icons/step1.png'
                                        : 'assets/icons/step1.png',
                                title: 'Réception',
                                progress: controller.currentPage.value == 0
                                    ? 0
                                    : currentIndex <= 3
                                        ? (currentIndex + 1) / 5
                                        : 1.0,
                                stepNumber: "1",
                              );
                            }),
                            Obx(() {
                              final currentIndex =
                                  controller.currentQuestionIndex.value;
                              return StepWidget(
                                isCompleted:
                                    controller.isStepCompleted(2, currentIndex),
                                isDisabled:
                                    !controller.isStepActive(2, currentIndex),
                                image: controller.isStepCompleted(
                                        2, currentIndex)
                                    ? 'assets/icons/step2.png'
                                    : controller.isStepActive(2, currentIndex)
                                        ? 'assets/icons/step2.png'
                                        : 'assets/icons/step2disabled.png',
                                title: 'Préparation',
                                progress: currentIndex >= 5 && currentIndex <= 9
                                    ? (currentIndex - 4) / 5
                                    : currentIndex > 9
                                        ? 1.0
                                        : 0.0,
                                stepNumber: "2",
                              );
                            }),
                            Obx(() {
                              final currentIndex =
                                  controller.currentQuestionIndex.value;
                              return StepWidget(
                                isCompleted:
                                    controller.isStepCompleted(3, currentIndex),
                                isDisabled:
                                    !controller.isStepActive(3, currentIndex),
                                image: controller.isStepCompleted(
                                        3, currentIndex)
                                    ? 'assets/icons/step3.png'
                                    : controller.isStepActive(3, currentIndex)
                                        ? 'assets/icons/step3.png'
                                        : 'assets/icons/step3disabled.png',
                                title: 'Validation',
                                progress:
                                    controller.isStepActive(3, currentIndex)
                                        ? 1
                                        : 0,
                                stepNumber: "3",
                              );
                            }),
                            Obx(() {
                              final currentIndex =
                                  controller.currentQuestionIndex.value;
                              return StepWidget(
                                isCompleted:
                                    controller.isStepCompleted(4, currentIndex),
                                isDisabled:
                                    !controller.isStepActive(4, currentIndex),
                                image: controller.isStepCompleted(
                                        4, currentIndex)
                                    ? 'assets/icons/step4.png'
                                    : controller.isStepActive(3, currentIndex)
                                        ? 'assets/icons/step4.png'
                                        : 'assets/icons/step4disabled.png',
                                title: 'Finalisation',
                                progress:
                                    controller.isStepActive(4, currentIndex)
                                        ? 1
                                        : 0,
                                stepNumber: "4",
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 45,
                      top: 25,
                      child: Obx(() {
                        final questionPageIndex =
                            controller.currentPage.value - 1;

                        if (controller.currentPage.value == 0) {
                          return CustomButton(
                            onPressed: () => nextPage(),
                            isDisabled: false,
                            title: "COMMENCER",
                            width: screenWidth > 1900 ? 325 : 220,
                            height: 75,
                            icon: Image.asset("assets/icons/butonrightpng.png"),
                          );
                        }

                        final currentQuestion =
                            _questionsPerPage[questionPageIndex]
                                [controller.currentQuestionIndex.value];
                        final selectedList = controller.selectedAnswers[
                            controller.currentQuestionIndex.value];

                        final shouldDisable =
                            controller.currentQuestionIndex.value == 11
                                ? false
                                : selectedList.isEmpty;

                        return CustomButton(
                          onPressed: () {
                            if (shouldDisable) return;

                            final qIndex =
                                controller.currentQuestionIndex.value;

                            // Special case for question 11 — skip check, go next page
                            if (qIndex == 11) {
                              nextPage();
                              return;
                            }

                            bool isCorrect = false;
                            final listEquality = const ListEquality<int>();

                            if (qIndex == 8) {
                              // ✅ Special case: question 8 – partial scoring and dialog
                              final correctAnswers =
                                  currentQuestion.correctIndex.toSet();
                              final selectedAnswers = (selectedList).toSet();

                              final correctSelections =
                                  selectedAnswers.intersection(correctAnswers);
                              final numCorrect = correctSelections.length;

                              final showCorrectDialog = numCorrect > 0;
                              final double questionScore =
                                  (numCorrect * 0.5).clamp(0.0, 2.0);

                              if (showCorrectDialog) {
                                showWrongAnswerDialog(
                                  context,
                                  currentQuestion.correctDialog,
                                  numCorrect == 4
                                      ? "Bonne réponse complète !"
                                      : "Bonne réponse partielle !",
                                  true,
                                  700,
                                  1150,
                                  false,
                                );
                              } else {
                                showWrongAnswerDialog(
                                  context,
                                  currentQuestion.wrongDialog,
                                  "Mauvaise réponse",
                                  false,
                                  700,
                                  1150,
                                  false,
                                );
                              }

                              controller.calculateScore(_questionsPerPage);
                              isCorrect = numCorrect ==
                                  correctAnswers.length; // Full correct
                            } else {
                              // ✅ Normal logic for other questions
                              if (currentQuestion.correctIndices != null) {
                                isCorrect = listEquality.equals(
                                  selectedList,
                                  currentQuestion.correctIndices!,
                                );
                              } else {
                                final selectedSorted =
                                    (selectedList).toSet().toList()..sort();
                                final correctSorted = currentQuestion
                                    .correctIndex
                                    .toSet()
                                    .toList()
                                  ..sort();
                                isCorrect = listEquality.equals(
                                    selectedSorted, correctSorted);
                              }

                              if (isCorrect) {
                                showWrongAnswerDialog(
                                  context,
                                  currentQuestion.correctDialog,
                                  "Bonne réponse !",
                                  true,
                                  500,
                                  1150,
                                  false,
                                );
                              } else {
                                showWrongAnswerDialog(
                                  context,
                                  currentQuestion.wrongDialog,
                                  "Mauvaise réponse",
                                  false,
                                  700,
                                  1150,
                                  false,
                                );
                              }

                              controller.calculateScore(_questionsPerPage);
                            }

                            final isLastQuestionInPage = qIndex == 12;

                            if (isLastQuestionInPage) {
                              final bool lastIsCorrect = qIndex == 8
                                  ? (selectedList)
                                      .toSet()
                                      .intersection(
                                          currentQuestion.correctIndex.toSet())
                                      .isNotEmpty
                                  : (() {
                                      final selectedSorted = (selectedList)
                                          .toSet()
                                          .toList()
                                        ..sort();
                                      final correctSorted = currentQuestion
                                          .correctIndex
                                          .toSet()
                                          .toList()
                                        ..sort();
                                      return const ListEquality<int>().equals(
                                          selectedSorted, correctSorted);
                                    })();

                              if (lastIsCorrect) {
                                showWrongAnswerDialog(
                                  context,
                                  currentQuestion.correctDialog,
                                  "Bonne réponse !",
                                  true,
                                  500,
                                  1150,
                                  true,
                                );
                              } else {
                                showWrongAnswerDialog(
                                  context,
                                  currentQuestion.wrongDialog,
                                  "Mauvaise réponse",
                                  false,
                                  700,
                                  1150,
                                  true,
                                );
                              }

                              controller
                                  .updateUserScore(controller.score.value);
                            }
                          },
                          isDisabled: shouldDisable,
                          title: "CONTINUER",
                          width: screenWidth > 1900 ? 295 : 220,
                          height: 75,
                          icon: Image.asset("assets/icons/butonrightpng.png"),
                        );
                      }),
                    ),
                    Positioned(
                      left: 25,
                      top: 25,
                      child: ElevatedButton(
                        onPressed: () {
                          previousPage();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                            (states) {
                              if (states.contains(WidgetState.hovered)) {
                                return AppColors.yellow;
                              }
                              return Colors.white;
                            },
                          ),
                          shape: WidgetStateProperty.all(
                            CircleBorder(
                              side: BorderSide(
                                color: AppColors.yellow,
                                width: 0.5,
                              ),
                            ),
                          ),
                          padding: WidgetStateProperty.all(EdgeInsets.all(24)),
                        ),
                        child: Image.asset('assets/icons/button.png'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
