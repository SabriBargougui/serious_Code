import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 560, minWidth: 250),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: AppColors.brandBlue, width: 0.7),
            right: BorderSide(color: AppColors.brandBlue, width: 0.7),
            top: BorderSide(color: AppColors.brandBlue, width: 0.7),
            bottom: BorderSide(color: AppColors.brandBlue, width: 14),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(36),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 25),
                child: Text(
                  'Bienvenue dans la salle de réception du service d’Anatomie Pathologique',
                  style: TextStyles.textStyle2.copyWith(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              /// THIS PART fills remaining space
              Expanded(
                child: Stack(
                  children: [
                    /// Background image fills all available space
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/welcome.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    /// Doctor image aligned to the right
                    Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Image.asset(
                        "assets/images/doctor.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
