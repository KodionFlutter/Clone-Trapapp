import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:trapapp_clone/Model/nfc_validate_model.dart';
import 'package:trapapp_clone/Utils/constant.dart';
import 'package:video_player/video_player.dart';

class AuthenticProductController extends GetxController {
// For creating the Constructor
  var responseData;
  var serialNumber;
  NFCValidateModel? nfcValidateModel;

  AuthenticProductController(
      {this.responseData, this.serialNumber, this.nfcValidateModel});

  //! Declare the Variable.

  RxBool isPopupVisible = false.obs;
  RxString logoPath = ''.obs;
  RxString productUrl = ''.obs;
  RxString clientName = ''.obs;
  RxString clientUrl = ''.obs;
  RxString clientId = ''.obs;
  RxString videoUrl = ''.obs;
  RxList productImages = [].obs;
  late VideoPlayerController videoPlayerController;

  @override
  void onInit() {
    Future.delayed(Duration.zero).then((value) => initilization());
    try {
      if (responseData.isNotEmpty) {
        videoUrl.value = responseData['VIDEO_URL'];
        productImages.value = responseData['productImages'];
      } else {
        videoUrl.value = responseData['VIDEO_URL'];
      }
    } catch (e) {
      log("Error :: ${e.toString()}");
    }
    super.onInit();
    if (videoUrl.value.endsWith("mp4")) {
      initVideoController();
    }
    showPopUp();
  }

  @override
  void dispose() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    videoPlayerController.pause();
    super.onClose();
  }

  //! Make a init videoController method
  void initilization() {
    log("ResponseData :: $responseData");
    if (responseData.isNotEmpty) {
      logoPath.value = responseData['LOGO_PATH'].toString().replaceAll("http", "https");
      log("LogoPath :: ${logoPath.value}");
      productUrl.value = logoPath.value.toString();
      log("Product Url :: ${productUrl.value}");
      log("Logo Path :: ${responseData['LOGO_PATH']}");
      log("Video URL :: ${responseData['VIDEO_URL']}");
      clientName.value = responseData['CLIENT'];
      clientUrl.value = responseData['CLIENTURL'];
      clientId.value = responseData['CLIENT_ID'].toString();
    } else {
      logoPath.value = responseData['LOGO_PATH'].toString().replaceAll("http", "https");
      log("LogoPath :: ${logoPath.value}");
      clientName.value = responseData['CLIENT'];
      clientUrl.value = responseData['CLIENTURL'];
      clientId.value = responseData['CLIENT_ID'].toString();
    }
  }

  // Make a function for Hide PopUp
  void hidePopUp() {
    isPopupVisible.value = false;
  }

  // Make a function to show the PopUp
  void showPopUp() {
    isPopupVisible.value = true;
  }

  // Make a video play controller
  void initVideoController() {
    log("This is Video URL :: ${videoUrl.value}");
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl.value))
        ..initialize().then((v) {
          videoPlayerController.play();
          videoPlayerController.setLooping(true);
        });
  }

  ClipRect getBOXFitted(VideoPlayerController _controller) {
    final  size = MediaQuery.of(navigatorKey.currentState!.context).size;
    return  ClipRect(
        child: SizedBox.expand(
          child: new FittedBox(
              fit: BoxFit.fill,
              alignment: Alignment.center,
              child: new Container(
                //color: Colors.lightBlue,
                  width: size.width,
                  height: size.height,
                  child: new VideoPlayer(_controller))),
        ));
  }

}
