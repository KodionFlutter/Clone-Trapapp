import 'dart:io';
import 'package:flutter/material.dart';

class NfcLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
        backgroundColor: Colors.black.withOpacity(0),
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: Platform.isAndroid
                    ? ((MediaQuery.of(context).size.width - 180) / 2)
                    : ((MediaQuery.of(context).size.width - 150) /
                        2), // Center horizontally
                top: ((MediaQuery.of(context).size.height - 180) /
                    2), // Center vertically
                child: Image.asset("assets/images/newlogo.png",
                    width: Platform.isAndroid ? 180 : 150,
                    height: Platform.isAndroid ? 180 : 150),
              )
            ],
          ),
        ));
  }
}
