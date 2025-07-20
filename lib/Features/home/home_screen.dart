import 'dart:ui';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:serious_game/Features/ccommun/custom_button.dart';
import 'package:serious_game/Features/ccommun/custom_propo.dart';
import 'package:serious_game/Features/ccommun/custom_unput.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

import '../../core/service/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<LoginController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home.png'),
              fit: BoxFit.fill,
              alignment: Alignment.topRight,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo and "À propos" Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          width: 130,
                          height: 130,
                          image: AssetImage('assets/images/logo.png'),
                        ),
                        CustomPropoButton(
                          onPressed: () {},
                          height: 55,
                          width: 210,
                          title: 'À propos',
                          icon: Icons.error_outline,
                        ),
                      ],
                    ),

                    const SizedBox(height: 80), // replaces Positioned(top: 180)

                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 900,
                            child: Text(
                              "Bienvenue dans PathGame, votre simulateur éducatif d’Anatomie Pathologique.",
                              style: TextStyles.textStyle1.copyWith(
                                color: AppColors.darkBlue,
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 900,
                            child: Text(
                              "Explorez chaque étape du parcours d’un prélèvement anatomopathologique, de la réception au diagnostic. Conçu pour les étudiants en médecine, ce serious game vous plonge dans la réalité du laboratoire à travers des cas interactifs, visuels et pédagogiques.",
                              style: TextStyles.textStyle3.copyWith(
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 500,
                                child: Text(
                                  "Êtes-vous prêt à relever le défi ?",
                                  style: TextStyles.textStyle1.copyWith(
                                    color: AppColors.brandBlue,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 56,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              CustomButton(
                                onPressed: () {
                                  showSignupModal(context);
                                },
                                width:  295,
                                height: 76,
                                title: "Commencer",
                                icon: Image.asset(
                                    "assets/icons/butonrightpng.png"),
                                isDisabled: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSignupModal(BuildContext context) {
    final controller = Get.find<LoginController>();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Signup",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: AppColors.yellow,
                  width: 15,
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          width: 130,
                          height: 130,
                          image: AssetImage('assets/images/logo.png'),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              size: 40,
                            ))
                      ],
                    ),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.showSignup.value = true;
                              },
                              child: Text(
                                "S’inscrire",
                                style: TextStyle(
                                  fontWeight: controller.showSignup.value
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 18,
                                  color: controller.showSignup.value
                                      ? AppColors.brandBlue
                                      : Colors.black,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.showSignup.value = false;
                              },
                              child: Text(
                                "Se connecter",
                                style: TextStyle(
                                  fontWeight: !controller.showSignup.value
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 18,
                                  color: !controller.showSignup.value
                                      ? AppColors.brandBlue
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )),

                    const SizedBox(height: 20),

                    // AnimatedSwitcher for smooth form transition
                    Obx(() => AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                          child: controller.showSignup.value
                              ? singupForm(controller, context)
                              : loginForm(controller, context),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final offsetAnimation = Tween<Offset>(
          begin: Offset(-1.0, 0), // Start fully off-screen to the left
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeInOut));

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Material singupForm(LoginController controller, BuildContext context) {
    return Material(
      // 👈 Add this
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 750, maxWidth: 600),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.brandBlue,
                  width: 0.3,
                )),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Créer un compte",
                    style: TextStyles.textStyle2.copyWith(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Veuillez remplir les champs ci-deessous",
                    style: TextStyles.textStyle2.copyWith(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 50),
                  CustomInputField(
                    isHidden: false,
                    title: "Email institutionnel",
                    controller: controller.emailController,
                  ),
                  Obx(() => controller.emailError.isNotEmpty
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(controller.emailError.value,
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        )
                      : SizedBox()),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInputField(
                    isHidden: false,
                    title: "Nom et prénom",
                    controller: controller.usernameController,
                  ),
                  Obx(() => controller.usernameError.isNotEmpty
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(controller.usernameError.value,
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        )
                      : SizedBox()),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInputField(
                    isHidden: true,
                    title: "Mot de passe",
                    controller: controller.passwordController,
                  ),
                  Obx(() => controller.passwordError.isNotEmpty
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(controller.passwordError.value,
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        )
                      : SizedBox()),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              CustomInputField(
                                isHidden: false,
                                title: "Age",
                                controller: controller.ageController,
                              ),
                              Obx(() => controller.ageError.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(controller.ageError.value,
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox()),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Sexe",
                                style: TextStyles.textStyle3.copyWith(
                                    color: AppColors.darkBlue, fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              DropDownTextField(
                                controller: controller.cnt,
                                clearOption: true,
                                enableSearch: false,
                                dropDownItemCount: 2,
                                textFieldDecoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide:
                                        BorderSide(color: AppColors.darkBlue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: AppColors.darkBlue, width: 1.5),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 16.0),
                                ),
                                dropDownList: const [
                                  DropDownValueModel(
                                      name: 'Homme', value: "homme"),
                                  DropDownValueModel(
                                      name: 'Femme', value: "femme"),
                                ],
                                onChanged: (val) {
                                  // handle value change
                                },
                              ),
                              Obx(() => controller.sexError.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(controller.sexError.value,
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return AppColors.brandBlue;
                              } else {
                                return Colors.white;
                              }
                            }),
                            value: controller.isSigned.value,
                            onChanged: (value) {
                              controller.isSigned.value = value!;
                            },
                          ),
                          Flexible(
                            child: Text(
                              "En créant un compte, j'accepte les conditions d'utilisation et la politique de confidentialité. ",
                              style: TextStyles.textStyle3
                                  .copyWith(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : CustomButton(
                          isDisabled: false,
                          title: "S’inscrire",
                          width: 250,
                          height: 76,
                          onPressed: () async {
                            await controller.signup();
                            if (controller.errorMessage.isEmpty &&
                                controller.isSigned.value) {
                              context.push('/landing');
                            }
                          },
                        )),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => controller.errorMessage.isNotEmpty
                      ? Text(controller.errorMessage.value,
                          style: TextStyle(color: Colors.red))
                      : SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm(LoginController controller, BuildContext context) {
    return Material(
      key: ValueKey('login'), // Important for AnimatedSwitcher
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 600,
          height: 750,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.brandBlue,
              width: 0.3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 25, left: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Se connecter",
                  style: TextStyles.textStyle2.copyWith(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  isHidden: false,
                  title: "Email",
                  controller: controller.emailController,
                ),
                Obx(() => controller.emailError.isNotEmpty
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(controller.emailError.value,
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      )
                    : SizedBox()),
                const SizedBox(height: 20),
                CustomInputField(
                  isHidden: true,
                  title: "Mot de passe",
                  controller: controller.passwordController,
                ),
                Obx(() => controller.passwordError.isNotEmpty
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(controller.passwordError.value,
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      )
                    : SizedBox()),
                const SizedBox(height: 30),
                Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : CustomButton(
                        isDisabled: false,
                        title: "Se connecter",
                        width: 270,
                        height: 76,
                        onPressed: () async {
                          await controller.login();
                          if (controller.errorLoginMessage.isEmpty &&
                              controller.isSigned.value) {
                            context
                                .push('/landing'); // Navigate if login success
                          }
                        },
                      )),

                const SizedBox(height: 10),

                /// Backend error message (e.g. wrong password)
                Obx(() => controller.errorLoginMessage.isNotEmpty
                    ? Text(controller.errorLoginMessage.value,
                        style: TextStyle(color: Colors.red))
                    : SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
