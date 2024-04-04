import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trapapp_clone/Common/App_colors/app_colors.dart';
import 'package:trapapp_clone/Common/widgets/btn_widget.dart';
import 'package:trapapp_clone/Utils/constant.dart';

class ReadyToScanWidget extends StatelessWidget {

   ReadyToScanWidget({super.key, });

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      insetPadding: const EdgeInsets.all(18),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Text(
                    'Ready to scan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.blackColors,
                      fontSize: 22,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: SizedBox(
                  height: 90,
                  width: 120,
                  child: Image.asset(
                    "assets/images/nfcimage.png",
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              SizedBox(
                width: 329,
                child: Text(
                  Strings.nfcText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.blackColors,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15 , bottom: 15),
                  child: SizedBox(
                      height: 49,
                      width: double.infinity,
                      child: ButtonWidget(
                        btnOnPressed: () {},
                        btnHeight: size.height*0.1,
                        btnWidth: size.width,
btnBackgroundColor: AppColors.lendingPageBackgroundColor,
                        btnText: 'Cancle',
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
