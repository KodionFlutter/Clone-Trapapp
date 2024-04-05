import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:trapapp_clone/Common/widgets/alert_dialog_widget.dart';
import 'package:trapapp_clone/Model/login_model.dart';
import 'package:trapapp_clone/Model/nfc_validate_model.dart';
import 'package:trapapp_clone/Screens/Authentic/pages/authentic_product_page.dart';
import 'package:trapapp_clone/Screens/Authentic/pages/ready_scan_page.dart';
import 'package:trapapp_clone/Screens/Authentic/widgets/alert_dialogbox_orange2.dart';
import 'package:trapapp_clone/Screens/Authentic/widgets/not_available_nfc_widget.dart';
import 'package:trapapp_clone/Screens/Nfc_loading/nfc_loading.dart';
import 'package:trapapp_clone/Utils/constant.dart';
import 'package:http/http.dart' as http;

class ScanProductController extends GetxController {
  //https://api.trapapp.io/index.cfm
  RxBool isAvailable = true.obs;
  RxString userServiceToken = "".obs;
  RxBool isShowingAnimationScreen = false.obs;

  @override
  void onInit() {
    Timer(Duration(seconds: 0), () {
      //Calling the NFC Scan
      NFCScan(true);
    });
    super.onInit();
    login();
  }

  // Check the InterNet Connection .

  Future<bool> isInternetConnected() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      log("Connection result :: ${connectivityResult}");
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        log("true");
        return true;
      } else {
        log("false");

        return false;
      }
    } catch (e) {
      log("Error checking internet connection: $e");
      return false;
    }
  }

  // The checking NFC Scan
  void NFCScan(enable) {
    log("NFCScan :: running");
    if (Platform.isAndroid) {
      log("Platform :: Android");
      NfcManager.instance.startSession(onDiscovered: (NfcTag nfcTag) async {
        if (enable && !isShowingAnimationScreen.value) {
          final ndefTag = await Ndef.from(nfcTag);
          String nfcURL = "";
          log("Ndef message :: ${ndefTag!.cachedMessage}");
          if (ndefTag?.cachedMessage != null) {
            var ndefMessage = ndefTag?.cachedMessage;
            var buffer = StringBuffer();
            try {
              final ndefRecords = ndefMessage!.records;
              for (int i = 0; i < ndefRecords!.length; i++) {
                final nPalyload = ndefRecords[i].payload;
                String decodedData = utf8.decode(nPalyload.toList());
                log("DecodedData :: ${decodedData}");
                if (decodedData.isNotEmpty) {
                  if (decodedData.contains("trapapp.io/nfc")) {
                    log("Yes this contain");
                    nfcURL = decodedData.substring(1);
                    log("NFC URL :: $nfcURL");
                  } else {
                    log("Not contain");
                    buffer.writeln(
                        "Record " + (i + 1).toString() + ". " + decodedData);
                    log("Buffer Write :: ${buffer}");
                  }
                } else {
                  log("$decodedData Is Empty");
                }
              }
            } catch (exception) {
              log("Exceptions :: ${exception.toString()}");
            }
          }
          if (await isInternetConnected()) {
            showNFCLoadingScreen(navigatorKey.currentState!.context);
            log("Internet is Connected");
            if (userServiceToken.isEmpty) {
              await login();
              log("userServiceToken isAvailable :: ${userServiceToken.value}");
              validateNFCTag(navigatorKey.currentState!.context,
                  getSerialNumberFromTag(nfcTag), nfcURL);
            } else {
              log("userServiceToken :: ${userServiceToken.value}");
              validateNFCTag(navigatorKey.currentState!.context,
                  getSerialNumberFromTag(nfcTag), nfcURL);
            }
          } else {
            showDialog(
                context: navigatorKey.currentState!.context,
                builder: (_) {
                  return AlertDialogBoxWidget(
                    title: 'Alert',
                    message: 'You are offline',
                  );
                });
          }
        }
      }, onError: (NfcError error) async {
        log("NFC Error :: $error");
      });
    }
  }

  // here is the Admin Login Auto.
  Future login() async {
    String email = 'admin@trapapp.io';
    String password = 'Test@1234';
    final String apiUrl = "${Api_Url}?endpoint=%2Fauthenticate";
    print("apiUrl :: ${apiUrl}");
    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        "email": email,
        "password": password,
      });
      log("HTTP response :: ${response.body.toString()}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["success"] == true) {
          var userData = LoginModel.fromJson(data);
          userServiceToken.value = userData.token!;
          log("user Token :: ${userServiceToken}");
        }
      } else {
        log("Hide The NFC Page");
      }
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  // Calling the NFC Loading screen
  showNFCLoadingScreen(BuildContext context) {
    isShowingAnimationScreen.value = true;
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return NfcLoadingScreen();
      },
    );
  }

  // to check the NFC is Available or Not
  void tagRead() async {
    log("Tag read button :: ");
    isAvailable.value = await NfcManager.instance.isAvailable();
    log(isAvailable.toString());
    if (!isAvailable.value) {
      showDialog(
          context: navigatorKey.currentState!.context,
          builder: (builder) {
            return NotAvailableWidget(
              height: MediaQuery.of(navigatorKey.currentState!.context)
                      .size
                      .height *
                  0.3,
              message: "Please enable NFC in settings",
            );
          });
      log('NFC is not available');
    } else {
      if (Platform.isAndroid) {
        showDialog(
            context: navigatorKey.currentState!.context,
            builder: (_) => ReadyScanPage());
      }
    }

    NfcManager.instance.startSession(
      onDiscovered: (NfcTag nfcTag) async {
        if (Platform.isAndroid) {
          Get.back();
        }
        if (Platform.isIOS) {
          try {
            NfcManager.instance.stopSession();
          } catch (exception) {
            log("Ios NFC manage exception :: ${exception.toString()}");
          }
        }

        final ndefTag = await Ndef.from(nfcTag);
        String nfcURL = "";
        log("Ndef message :: ${ndefTag!.cachedMessage}");
        if (ndefTag?.cachedMessage != null) {
          var ndefMessage = ndefTag?.cachedMessage;
          var buffer = StringBuffer();
          try {
            final ndefRecords = ndefMessage!.records;
            for (int i = 0; i < ndefRecords!.length; i++) {
              final nPalyload = ndefRecords[i].payload;
              String decodedData = utf8.decode(nPalyload.toList());
              log("DecodedData :: ${decodedData}");
              if (decodedData.isNotEmpty) {
                if (decodedData.contains("trapapp.io/nfc")) {
                  log("Yes this contain");
                  nfcURL = decodedData.substring(1);
                  log("NFC URL :: $nfcURL");
                } else {
                  log("Not contain");
                  buffer.writeln(
                      "Record " + (i + 1).toString() + ". " + decodedData);
                  log("Buffer Write :: ${buffer}");
                }
              } else {
                log("$decodedData Is Empty");
              }
            }
          } catch (exception) {
            log("Exceptions :: ${exception.toString()}");
          }
        }
        // Here we check the internet connecting or not

        if (await isInternetConnected()) {
          showNFCLoadingScreen(navigatorKey.currentState!.context);
          if (userServiceToken.value.isEmpty) {
            await login();
            validateNFCTag(navigatorKey.currentState!.context,
                getSerialNumberFromTag(nfcTag), nfcURL);
            log("Internet is Connected");
          } else {
            validateNFCTag(navigatorKey.currentState!.context,
                getSerialNumberFromTag(nfcTag), nfcURL);
            log("Internet is Connected");
          }
        } else {
          showDialog(
              context: navigatorKey.currentState!.context,
              builder: (_) {
                return AlertDialogBoxWidget(
                  title: 'Alert',
                  message: 'You are offline here',
                );
              });
        }
      },
      onError: (NfcError error) async {
        if (Platform.isIOS) {
          try {
            NfcManager.instance.stopSession();
          } catch (_) {
            //We dont care
          }
        }
        log("Error :: $error");
      },
    );
  }

  //! Making a method to get Serial Number from Tag ..

  String getSerialNumberFromTag(NfcTag tag) {
    String identifier1 = "N/A";
    log("Tag Data :: ${tag.toString()}");
    try {
      if ((Platform.isAndroid)) {
        Uint8List identifier =
            Uint8List.fromList(tag.data["ndef"]['identifier']);
        identifier1 = identifier
            .map((e) => e.toRadixString(16).padLeft(2, '0'))
            .join(':');
      } else {
        Uint8List identifier =
            Uint8List.fromList(tag.data["mifare"]['identifier']);
        identifier1 = identifier
            .map((e) => e.toRadixString(16).padLeft(2, '0'))
            .join(':');
      }
      print("Serial number " + identifier1);
    } catch (e) {}

    return "" + identifier1;
  }

//! Making a function for validate the NFC tag
  Future validateNFCTag(
      BuildContext context, String serialNumber, String productPage) async {
    if (userServiceToken.value.isEmpty ||
        userServiceToken.value.toString().isEmpty) {
      AlertDialogBoxWidget(
        title: 'Authorization Error',
        message: 'Token is empty',
      );
    }
    final queryParameter = {
      'serial_no': '${serialNumber}',
      'product_page': 'https://www.${productPage}',
    };
    final url = "${Api_Url}${nfcCodeValidation}";
    log("Code validation :: ${url.toString()}");
    log("Token :: ${userServiceToken.value.toString()}");

    try {
      final response = await http.get(
          Uri.parse(url).replace(queryParameters: queryParameter),
          headers: {
            'authorization': userServiceToken.value.toString(),
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        return http.Response('Error', 404);
      });
      log("Code Validation Response :: ${response.body.toString()}");
      if (isShowingAnimationScreen.value) {
        hideNFCLoadingScreen(navigatorKey.currentState!.context);
      }
      var data = json.decode(response.body);
      log("Decoded code validateion Data :: $data");
      var nfcValidateDataModel = NFCValidateModel.fromJson(data);
      if (response.statusCode == 200) {
        log("Response Success :: ${data['success']}");
        if (data["success"]) {
          if (data["CLIENT_ID"] == 1966 || data["IS_360"] == 1) {
            Future.delayed(Duration.zero).then((_) async {
              NFCScan(false);
              log("Client Id == 1966 & IS_360 == 1 :: TRUE");
              var back = await Get.to(() => AuthenticProductPage(
                    responseData: data,
                    serialNumber: serialNumber,
                    nfcValidateModel: null,
                  ));
              if (back) {
                NFCScan(true);
              }
            });
          } else if (data['VIDEO_URL'].isNotEmpty) {
            await Future.delayed(Duration.zero).then((value) async {
              NFCScan(false);
              log("VIDEO URL isNotEmpty");
              // hide your widget
              var back = await Get.to(AuthenticProductPage(
                    responseData: data,
                    serialNumber: serialNumber,
                    nfcValidateModel: nfcValidateDataModel,
                  ));
              if (back) {
                NFCScan(true);
              }
            });
          } else {
            log("89790==>${data['LOGO_PATH']}");
            //A calling the Alert Dialog  Orange2 Box
            showDialog(
                context: navigatorKey.currentState!.context,
                builder: (_) {
                  return AlertDialogBoxOrange2Widget(
                    nfcValidateModel: data,
                    serialNumber: serialNumber,
                  );
                });
          }
        } else {
          try {
            AlertDialogBoxWidget(
              title: 'data["success"]',
              message: 'Is False',
            );
          } catch (e) {}
        }
      }
    } catch (exception) {
      log("Exception :: ${exception.toString()}");
    }
  }

  //! Hide NFC Loading Screen
  hideNFCLoadingScreen(BuildContext context) {
    isShowingAnimationScreen.value = false;
    Get.back();
  }
}
