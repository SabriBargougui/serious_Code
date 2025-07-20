import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class StepCard extends StatelessWidget {
  final String title;
  final String question;
  final String? image;
  final Widget widget;
  final String? image2;
  final bool isHasResizeImlage;
  final double? imageSize;
  final double? textWidht;
  final Widget? questionWidget;
  final bool? ishasBigImage;

  const StepCard({
    super.key,
    required this.title,
    required this.question,
    this.image,
    required this.widget,
    this.image2,
    required this.isHasResizeImlage,
    this.imageSize,
    this.textWidht,
    this.questionWidget,
    this.ishasBigImage,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 580, minWidth: 250),
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
          padding: const EdgeInsets.only(top: 70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ==== LEFT SIDE: Text and Widget ====
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 80),

                      /// Title
                      Padding(
                        padding: const EdgeInsets.only(left: 75, bottom: 5),
                        child: Text(
                          title,
                          style: TextStyles.textStyle2.copyWith(
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth > 1900 ? 30 : 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Question Text or Widget
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 75),
                        child: questionWidget ??
                            SizedBox(
                              width: screenWidth > 1900
                                  ? screenWidth * 0.7
                                  : screenWidth * 0.7,
                              child: Text(
                                question,
                                style: TextStyles.textStyle2.copyWith(
                                  color: AppColors.darkBlue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth > 1900 ? 42 : 28,
                                ),
                                softWrap: true,
                              ),
                            ),
                      ),

                      /// Bottom Widget
                      widget,
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              /// ==== RIGHT SIDE: Image and Zoom Button ====
              if (image != "")
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => isHasResizeImlage
                            ? showFullImage(context, image2!, 800)
                            : null,
                        child: Image.asset(
                          image ?? "",
                          fit: BoxFit.contain,
                          height: screenHeight > 900
                              ? 480
                              : (screenHeight > 700 ? 360 : 250),
                        ),
                      ),
                      if (isHasResizeImlage)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: screenWidth > 1900 ? 430 : 300,
                            height: 76,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36),
                                    side: BorderSide(
                                      color: AppColors.brandBlue,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.white),
                              ),
                              onPressed: () => showFullImage(
                                  context, image2!, imageSize ?? 600),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.zoom_in,
                                    size: screenWidth > 1900 ? 46 : 30,
                                    color: AppColors.brandBlue,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Cliquer sur l’image pour zoomer",
                                    style: TextStyles.textStyle3.copyWith(
                                      color: AppColors.darkBlue,
                                      fontSize: screenWidth > 1900 ? 18 : 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  void showFullImage(
      BuildContext context, final String image, double? imageSize) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            width: 900,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white, width: 0.3),
            ),
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    image,
                    height: imageSize ?? 850,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.brandBlue,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
