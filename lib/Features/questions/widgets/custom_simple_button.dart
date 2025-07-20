import 'package:flutter/material.dart';
import 'package:serious_game/core/colors.dart';
import 'package:serious_game/core/font.dart';

class CustomSimpleButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final String number;
  final bool isSelected;
  final double width;
  final double heigh;
  const CustomSimpleButton({
    super.key,
    this.onPressed,
    required this.title,
    required this.number,
    required this.isSelected,
    required this.width,
    required this.heigh,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1 : 1,
      child: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: width,
              height: heigh,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    // ignore: deprecated_member_use
                    color: Colors.blue.withOpacity(isSelected ? 1 : 0.7),
                    width: 2.5,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onPressed,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: AppColors.darkBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
 
            isSelected
                ? Positioned(
                    top: -35,
                    left: (width * 0.4),
                    child: Container(
                      width: 45,
                      height: 45,
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
                : SizedBox(
                    height: 10,
                  ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    final Path path = Path()
      ..moveTo(0, 0) // top-left
      ..lineTo(size.width / 2, size.height) // bottom-center
      ..lineTo(size.width, 0) // top-right
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
