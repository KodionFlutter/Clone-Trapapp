import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:trapapp_clone/Common/App_colors/app_colors.dart';

class NotAvailableWidget extends StatelessWidget {
  final String message;
  final double height;

  const NotAvailableWidget(
      {super.key, required this.message, required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          height: height,
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 15, top: 15),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.cancel_outlined, size: 28),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: AppColors.blackColors.withOpacity(0.3),
                radius: 50,
                child: const Image(
                    image: AssetImage('assets/images/newlogo.png'),
                    width: 130,
                    height: 100),
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                      color: Colors.transparent,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Html(
                            data: message,
                            style: {
                              "*": Style(
                                textAlign: TextAlign.center,
                                alignment: Alignment.center,
                                fontSize: FontSize(20, Unit.px),
                                color: AppColors.errorTxtColor,
                                display: Display.block,
                                fontFamily: 'Montserrat',
                              ),
                              "b": Style(
                                textAlign: TextAlign.center,
                                alignment: Alignment.center,
                                color: AppColors.errorTxtColor,
                                fontSize: FontSize(25, Unit.px),
                                display: Display.block,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            },
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
