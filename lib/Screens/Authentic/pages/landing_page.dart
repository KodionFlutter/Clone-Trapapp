import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trapapp_clone/Common/App_colors/app_colors.dart';
import 'package:trapapp_clone/Common/Text_style/text_style.dart';
import 'package:trapapp_clone/Common/widgets/btn_widget.dart';
import 'package:trapapp_clone/Screens/Authentic/controller/authentic_controller.dart';

class LandingPage extends StatelessWidget {
   LandingPage({super.key});
  final authenticController = Get.put(AuthenticController());

  @override
  Widget build(BuildContext context) {
    // Getting the screen size
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lendingPageBackgroundColor,
      body: GestureDetector(
        onTap: (() {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: ListView(
              children: [
                const SizedBox(height: 35),
                Image.asset(
                  'assets/images/newlogo.png',
                  width: size.width*0.5,
                  height: size.height*0.2,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Protect Your Brand',
                  textAlign: TextAlign.center,
                  style: CommonTextStyle.largeTextStyle,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Welcome back to Trap App!',
                    textAlign: TextAlign.center,
                    style: CommonTextStyle.mediumTextStyle,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 40, left: 15, right: 15, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/nfcs.png",
                          color: AppColors.whiteColor,
                          height: size.height*0.3,
                        ),

                        //! Calling ButtonWidget
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 15, right: 15, bottom: 10),
                          child: ButtonWidget(
                            btnOnPressed: () {
                              //! Calling the NFC TagRead method
                              authenticController.tagRead();
                            },
                            btnHeight: size.height * 0.06,
                            btnWidth: size.width,
                            btnText: 'Scan Product',
                            btnBackgroundColor: AppColors.btnBackgroundBlackColor,
                          ),
                        ),
                      ],
                    )),
                // Version of app
                const Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text(
                    "v 1.2.3",
                    style: CommonTextStyle.smallTextStyle,
                    textAlign: TextAlign.end,
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
