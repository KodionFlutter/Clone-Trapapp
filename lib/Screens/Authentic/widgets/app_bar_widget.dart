import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trapapp_clone/Screens/Authentic/controller/authentic_product_controller.dart';

class AppbarWidget extends StatelessWidget {
   AppbarWidget({super.key});

  final authenticProductController = Get.find<AuthenticProductController>();
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const ShapeDecoration(
            color: Color(0xFFF8F8F8),
            shape: CircleBorder(),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        (authenticProductController
            .logoPath.value.isEmpty)
            ? Container()
            : Container(
          alignment: Alignment.centerRight,
          height: Platform.isIOS ? 100 : 90,
          // width: width / 1.4,
          width: 125,
          // color: Colors.black,
          child: Padding(
            padding: Platform.isIOS
                ? const EdgeInsets.only(top: 10)
                : const EdgeInsets.only(
                top: 0, right: 5),
            child: CachedNetworkImage(
                imageUrl:
                authenticProductController
                    .logoPath.value
                    .toString(),
                fit: BoxFit.contain,
                errorWidget:
                    (context, url, error) {
                  return Material(
                    color: Colors.transparent
                        .withOpacity(0.8),
                    // <-- Add this, if needed
                    child: const Center(
                      child: Text(
                          'Couldn\'t load image',
                          overflow: TextOverflow
                              .visible,
                          textAlign:
                          TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              color:
                              Colors.black,
                              fontSize: 22)),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
