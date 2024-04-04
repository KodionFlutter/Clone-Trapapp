import 'package:flutter/material.dart';
import 'package:trapapp_clone/Common/App_colors/app_colors.dart';

class AlertDialogBoxWidget extends StatelessWidget {
  final String title;
  final String message;

  AlertDialogBoxWidget({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.whiteColor,
      titleTextStyle: TextStyle(
        fontSize: 16 , fontWeight: FontWeight.w600 , color: AppColors.blackColors,
      ),
      title: Text(title),
      content: Text(message),
    );
  }
}
