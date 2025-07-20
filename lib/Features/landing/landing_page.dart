import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:serious_game/Features/ccommun/custom_button.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';
import 'package:serious_game/core/service/landing_controller.dart';
import 'package:serious_game/core/service/questionaire_controller.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<QuestionaireController>()) {
      Get.delete<QuestionaireController>();
    }

    if (Get.isRegistered<LandingController>()) {
      Get.delete<LandingController>();
    }
    Get.put(QuestionaireController());
    Get.put(LandingController());
  }

  List<bool> isVisible = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    LandingController landingController = Get.put(LandingController());
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/landing.png",
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                      bottom: 20,
                    ),
                    child: const Image(
                      width: 170,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  Obx(() {
                    if (landingController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final profile = landingController.userProfile.value;

                    if (profile == null) {
                      return SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Bonjour ${profile['fullName'] ?? 'N/A'}',
                            style: TextStyles.textStyle1.copyWith(
                                color: AppColors.darkBlue, fontSize: 36),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              ' votre ancien score est :  ${profile['score'] ?? 'N/A'}',
                              style: TextStyles.textStyle1.copyWith(
                                  color: AppColors.darkBlue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(left: 75, top: 140),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandBlue),
                        children: [
                          TextSpan(
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brandBlue),
                              text: "Explorez le service\n"
                                  "d’Anatomie Pathologique.\n"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 75, top: 0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue),
                        children: [
                          TextSpan(
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkBlue),
                              text:
                                  "A travers cette visite, vous allez découvrir le \n"
                                  "service d’Anatomie Pathologique..\n"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight > 800
                            ? screenHeight * 0.10
                            : screenHeight * 0.08,
                        left: 75),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.blueAccent,
                              border: Border(
                                left: BorderSide(
                                    color: AppColors.blueAssentDark,
                                    width: 0.7),
                                right: BorderSide(
                                    color: AppColors.blueAssentDark,
                                    width: 0.7),
                                top: BorderSide(
                                    color: AppColors.blueAssentDark,
                                    width: 0.7),
                                bottom: BorderSide(
                                    color: AppColors.blueAssentDark, width: 10),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                  bottomLeft: Radius.circular(36),
                                  bottomRight: Radius.circular(36)),
                            ),
                            height: 140,
                            width: 550,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: Text(
                                    style: TextStyles.textStyle2.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                    "Cliquez sur chaque numéro pour explorer les différentes salles et comprendre leur rôle dans l’examen anatomopathologique."),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -65,
                          left: (550 / 2) - 75,
                          child: Image.asset("assets/images/righticon.png"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: AppColors.backgroundColorLight.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15, right: 25),
                    child: CustomButton(
                      onPressed: () {
                        context.push('/welcome');
                      },
                      title: "Démarrer",
                      width: 260,
                      height: 66,
                      isDisabled: false,
                      icon: Image.asset("assets/icons/butonrightpng.png"),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.3, // instead of 640
              top: screenHeight * 0.1, // instead of 166

              child: InkWell(
                onTap: () {
                  setState(() {
                    isVisible[0] = !isVisible[0];
                  });

                  showWrongAnswerDialog(
                    context,
                    700,
                    1400,
                    "assets/icons/Salle2.png",
                    "Réception Anatomie  Pathologique",
                    "Bienvenue dans le service d’Anatomie Pathologique! En tant qu’apprenant, votre première étape se déroule ici.  👉 À la réception, vous recevez les flacons contenant les prélèvements ainsi que leur fiche de demande.  Vous devrez vérifier que la fiche de demande est bien remplie et tout est conforme avant de débuter l’analyse",
                    "assets/images/number1.png",
                  );
                },
                child: Transform(
                  transform: Matrix4.rotationX(-0.4),
                  child: Image.asset(
                    "assets/images/mainhidden1.png",
                    width: 400,
                  ),
                ),
              ),
            ),
            Positioned(
              right: screenWidth * 0.25, // 400 ÷ 1600 ~ 0.25 if full HD
              top: screenHeight * 0.09, // 70 ÷ 800 ~ 0.0875

              child: InkWell(
                onTap: () {
                  setState(() {
                    isVisible[1] = !isVisible[1];
                  });

                  showWrongAnswerDialog(
                    context,
                    700,
                    1400,
                    "assets/icons/Salle1.png",
                    "Salle de macroscopie Observation à l’œil nu",
                    "L’examen macroscopique se déroule dans cette salle.",
                    "assets/images/number2.png",
                  );
                },
                child: Transform(
                  transform: Matrix4.rotationX(-0.3),
                  child: Image.asset(
                    "assets/images/mainhidden2.png",
                    width: 400,
                  ),
                ),
              ),
            ),
            Positioned(
              right: screenWidth * 0.02, // 50 ÷ 1600 ~ 0.03
              top: screenHeight * 0.2, // 185 ÷ 800 ~ 0.23

              child: InkWell(
                onTap: () {
                  setState(() {
                    isVisible[2] = !isVisible[2];
                  });

                  showWrongAnswerDialog(
                    context,
                    700,
                    1400,
                    "assets/icons/Salle3.png",
                    "Salle technique Préparation des lames",
                    "Dans cette salle, il y’a plusieurs étapes techniques. L’objectif est d’avoir une lame lisible au microscope.",
                    "assets/images/number3.png",
                  );
                },
                child: Transform(
                  transform: Matrix4.rotationX(-0.3),
                  child: Image.asset(
                    "assets/images/mainhidden3.png",
                    height: 400,
                  ),
                ),
              ),
            ),
            Positioned(
              right: screenWidth * 0.2, // 360 ÷ 1600 ~ 0.225
              top: screenHeight * 0.3, // 360 ÷ 800 ~ 0.45

              child: InkWell(
                onTap: () {
                  setState(() {
                    isVisible[3] = !isVisible[3];
                  });

                  showWrongAnswerDialog(
                    context,
                    700,
                    1400,
                    "assets/images/Salle4.png",
                    "Bureau médical Analyse au microscope",
                    "Vous êtes amener à examiner la lame au microscope.",
                    "assets/images/number4.png",
                  );
                },
                child: Transform(
                  transform: Matrix4.rotationX(-0.3),
                  child: Image.asset(
                    "assets/images/mainhidden4.png",
                    height: 400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showWrongAnswerDialog(BuildContext context, double height, double width,
      String mainImage, String title, String textst, String numberImage) {
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
                    left: BorderSide(color: AppColors.yellow, width: 0.7),
                    right: BorderSide(color: AppColors.yellow, width: 0.7),
                    top: BorderSide(color: AppColors.yellow, width: 0.7),
                    bottom: BorderSide(color: AppColors.yellow, width: 14),
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    // Left side: Your custom widgets
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(numberImage),
                            SizedBox(height: 50),
                            Text(
                              title,
                              style: TextStyles.textStyle1.copyWith(
                                color: AppColors.brandBlue,
                                fontWeight: FontWeight.w700,
                                fontSize: 42,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              textst,
                              style: TextStyles.textStyle3.copyWith(
                                color: AppColors.darkBlue,
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // Right side: Gradient image
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(32),
                                bottomRight: Radius.circular(30),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/gradien.png"),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 150,
                              top: 120,
                              child: Image.asset(mainImage),
                            ),
                            Positioned(
                              right: 40,
                              top: 40,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: Image.asset("assets/images/close.png"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
