import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trapapp_clone/Common/App_colors/app_colors.dart';
import 'package:trapapp_clone/Screens/Code_verification/widgets/common_web_view_widget.dart';

class AlertDialogBoxOrange2Widget extends StatelessWidget {
  var nfcValidateModel;
  final String serialNumber;

  AlertDialogBoxOrange2Widget(
      {super.key, required this.nfcValidateModel, required this.serialNumber});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          height: (nfcValidateModel['LOGO_PATH'] == null) ? 350 : 450,
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 15, top: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: AppColors.blackColors.withOpacity(.3),
                radius: 50,
                child: const Image(
                  image: AssetImage('assets/images/newlogo.png'),
                  width: 130,
                  height: 100,
                ),
              ),
              const SizedBox(height: 15),
              Material(
                  color: Colors.transparent, // <-- Add this, if needed
                  child: Text(
                    'Authentic Product',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF001834),
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              const SizedBox(height: 5),
              (nfcValidateModel['LOGO_PATH'].isEmpty)
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        height: 130,
                        width: size.width / 1.4,
                        child: Image.network(
                            '${nfcValidateModel['LOGO_PATH'].toString().replaceAll("http", "https")}',
                            fit: BoxFit.contain, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                          return Material(
                            color: Colors.transparent
                                .withOpacity(0.8), // <-- Add this, if needed
                            child: const Center(
                              child: Text('Couldn\'t load image',
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22)),
                            ),
                          );
                          //  Text('Sorry unable to load the image');
                        }),
                      ),
                    ),
              SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SizedBox(
                      height: 49,
                      width: double.infinity,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffBC0001)),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.to(CommonWebView(
                                  url: nfcValidateModel['CLIENTURL'],
                                  title: nfcValidateModel['CLIENT'],
                                ));
                                // _launch(code);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor:
                                    AppColors.lendingPageBackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'About ${nfcValidateModel['CLIENT']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              )))),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
