import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trapapp_clone/Screens/Authentic/widgets/ready_to_scan_widget.dart';

class ReadyScanPage extends StatelessWidget {
  const ReadyScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(child: SizedBox()),
        ReadyToScanWidget(),
      ],
    );
  }
}