import 'package:flutter/material.dart';
import 'package:trapapp_clone/Common/App_colors/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback btnOnPressed;
  final double btnHeight;
  final double btnWidth;
  final Color? btnBackgroundColor;
  final String btnText;

  const ButtonWidget({
    super.key,
    required this.btnOnPressed,
    required this.btnHeight,
    required this.btnWidth,
    this.btnBackgroundColor,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: btnHeight,
        width: btnWidth,
        child: ElevatedButton(
            onPressed: btnOnPressed,
            style: ElevatedButton.styleFrom(
              elevation: 1,
              backgroundColor: btnBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              btnText.toString(),
              style: const TextStyle(
                color: AppColors.txtWhiteColor,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            )));
  }
}
