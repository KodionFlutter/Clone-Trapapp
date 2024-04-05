import 'package:flutter/cupertino.dart';
import 'package:trapapp_clone/Common/App_colors/app_colors.dart';

class CommonTextStyle{

  static const largeTextStyle = TextStyle(
    color: AppColors.txtWhiteColor,
    fontSize: 24,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
  );

  static const mediumTextStyle = TextStyle(
    color: AppColors.txtWhiteColor,
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
  );

  static const mediumBoldTextStyle = TextStyle(
    color: AppColors.txtWhiteColor,
    fontSize: 16,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
  );

  static const smallTextStyle =TextStyle(color: AppColors.txtWhiteColor, fontSize: 12);
}