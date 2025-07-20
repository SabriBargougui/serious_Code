import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class CustomQ8 extends StatelessWidget {
  final String number;
  final double width;
  final bool isSelected;
  final double top;
  final double left;
  final double heigh;
  final String imagePath;
  final void Function()? onTap;
  const CustomQ8(
      {super.key,
      required this.number,
      required this.width,
      required this.isSelected,
      this.onTap,
      required this.top,
      required this.left,
      required this.heigh,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(onTap: onTap, child: Image.asset(imagePath)),
          isSelected
              ? Positioned(
                  top: top,
                  left: left,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.brandBlue,
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(1, 1),
                          ),
                        ],
                        border:
                            Border.all(color: AppColors.brandBlue, width: 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )),
                    child: Center(
                      child: Text(
                        number,
                        style: TextStyles.textStyle3.copyWith(
                          color: AppColors.brandBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
