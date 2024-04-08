import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trapapp_clone/Model/nfc_validate_model.dart';
import 'package:trapapp_clone/Screens/Authentic/controller/authentic_product_controller.dart';
import 'package:trapapp_clone/Screens/Authentic/widgets/app_bar_widget.dart';
import 'package:trapapp_clone/Screens/Code_verification/widgets/common_web_view_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AuthenticProductPage extends StatelessWidget {
  Map<String, dynamic> responseData;
  String serialNumber;
  NFCValidateModel? nfcValidateModel;

  AuthenticProductPage(
      {super.key,
      required this.responseData,
      required this.serialNumber,
      this.nfcValidateModel});

  @override
  Widget build(BuildContext context) {
    final authenticProductController = Get.put(AuthenticProductController(
      nfcValidateModel: nfcValidateModel,
      responseData: responseData,
      serialNumber: serialNumber,
    ));

    final size = MediaQuery.of(context).size;
    log("This is response Data :: ${responseData.toString()}");
    log("This is serialNumber :: ${serialNumber}");
    log("This is nfcModel Data :: ${nfcValidateModel!.success.toString()}");
    log("This is :::${authenticProductController.videoPlayerController.value.isInitialized}");
    log("Yes it is Contain :: ${authenticProductController.videoUrl.value.endsWith("mp4")}");
    return  PopScope(
          canPop: true,
          onPopInvoked: (bool isPop) {
            authenticProductController.videoPlayerController.pause();
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Obx(() =>  Container(

                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Stack(
                  children: [
                    if (authenticProductController.videoUrl.value
                        .endsWith("mp4"))
                      authenticProductController
                          .videoPlayerController.value.isInitialized
                          ? SizedBox(
                        width: size.width,
                        height: size.height,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            authenticProductController.getBOXFitted(
                                authenticProductController
                                    .videoPlayerController),
                          ],
                        ),
                      )
                          : Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: Platform.isAndroid
                                ? ((MediaQuery.of(context).size.width -
                                180) /
                                2)
                                : ((MediaQuery.of(context).size.width -
                                150) /
                                2), // Center horizontally
                            top: ((MediaQuery.of(context).size.height -
                                180) /
                                2.4), // Center vertically

                            child: Image.asset(
                              "assets/images/newlogo.png",
                              width: Platform.isAndroid ? 180 : 150,
                              height: Platform.isAndroid ? 180 : 150,
                            ),
                          )
                        ],
                      )
                    else if (responseData['is_360'] == 1)
                      const Center(
                        // child: LoadImages(
                        //   images: productImages.reversed.toList(),
                        // ),
                        child: SizedBox(),
                      )
                    else
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 130),
                          child: SizedBox(
                            height: 220,
                            width: size.width / 1.3,
                            child: CachedNetworkImage(
                                imageUrl: authenticProductController
                                    .productUrl.value
                                    .toString(),
                                fit: BoxFit.contain,
                                placeholder: (context, url) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned(
                                        left: Platform.isAndroid
                                            ? ((MediaQuery.of(context)
                                            .size
                                            .width -
                                            180) /
                                            2)
                                            : ((MediaQuery.of(context)
                                            .size
                                            .width -
                                            150) /
                                            2), // Center horizontally
                                        top: ((MediaQuery.of(context)
                                            .size
                                            .height -
                                            180) /
                                            2.4), // Center vertically

                                        child: Image.asset(
                                          "assets/images/newlogo.png",
                                          width: Platform.isAndroid
                                              ? 180
                                              : 150,
                                          height: Platform.isAndroid
                                              ? 180
                                              : 150,
                                        ),
                                      )
                                    ],
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Material(
                                    color:
                                    Colors.transparent.withOpacity(0.8),
                                    // <-- Add this, if needed
                                    child: const Center(
                                      child: Text('Couldn\'t load image',
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22)),
                                    ),
                                  );
                                }),),
                        ),
                      ),
                    Positioned(
                      top: 30,
                      right: 0,
                      left: 10,
                      child: Row(
                        children: [
                          // Calling here appBar widget
                          Expanded(
                            child: AppbarWidget()
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: Platform.isIOS ? 20 : 6,
                      right: 10,
                      left: 10,
                      child: Container(
                          width: size.width / 1.1,
                          padding:const EdgeInsets.only(top: 5, bottom: 15),
                          decoration: ShapeDecoration(
                            color: Colors.black87.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 5,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 10, top: 15),
                              child: Column(children: [
                                authenticProductController
                                    .clientName.value.isNotEmpty
                                    ? Text(
                                  'Authentic ${authenticProductController.clientName.value} Product',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                    : const Text(
                                  'Authentic Product',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                (authenticProductController
                                    .logoPath.value.isEmpty)
                                    ? SizedBox(height: 10)
                                    : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: SizedBox(
                                    height: 90,
                                    width: size.width / 1.4,
                                    child: CachedNetworkImage(
                                      imageUrl: authenticProductController
                                          .logoPath.value,
                                      fit: BoxFit.contain,
                                      errorWidget: (context, url, error) {
                                        return Material(
                                          color: Colors.transparent
                                              .withOpacity(
                                              0.8), // <-- Add this, if needed
                                          child: const Center(
                                            child: Text(
                                                'Couldn\'t load image',
                                                //softWrap: false,
                                                overflow:
                                                TextOverflow.visible,
                                                textAlign:
                                                TextAlign.center,
                                                maxLines: 2,
                                                // overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22)),
                                          ),
                                        );
                                        //  Text('Sorry unable to load the image');
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  (serialNumber.isNotEmpty &&
                                      serialNumber.contains(":"))
                                      ? "Scan Count: ${responseData['SCANCOUNT'].toString().replaceAll(".0", "")}"
                                      : serialNumber,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: serialNumber.isEmpty
                                        ? const EdgeInsets.only(
                                        top: 0, left: 15, right: 15)
                                        : const EdgeInsets.only(
                                      top: 10,
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: SizedBox(
                                        height: 49,
                                        width: double.infinity,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              color: Color(0xffBC0001),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.white12,
                                                    offset: Offset(3, 3),
                                                    blurRadius: 3),
                                                BoxShadow(
                                                    color: Colors.white12,
                                                    offset: Offset(-3, -3),
                                                    blurRadius: 3),
                                              ],
                                            ),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (authenticProductController
                                                      .videoUrl.value !=
                                                      "") {
                                                    authenticProductController
                                                        .videoPlayerController
                                                        .pause();
                                                  }
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CommonWebView(
                                                                  url:
                                                                  '${authenticProductController.clientUrl.value}?code=${serialNumber}',
                                                                  title:
                                                                  '${authenticProductController.clientName.value.toString()}'))).then(
                                                          (_) {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0.0,
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        16),
                                                  ),
                                                ),
                                                child: Text(
                                                  'About ${authenticProductController.clientName.value.toString() == "null" ? "" : authenticProductController.clientName.value.toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )))),
                                  ),
                                ),
                              ]))),
                    ),
                  ],
                ),
              ))
          )
        );
  }
}
