import 'package:flutter/material.dart';

import '../sabitler/color.dart';
import '../sabitler/text_style.dart';

// ignore: must_be_immutable
class SbtButon extends StatelessWidget {
  String label;
  Function() press;
  SbtButon({super.key, required this.label, required this.press});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          maximumSize: Size(size.width / 2, size.width / 4),
          minimumSize: Size(size.width / 4, size.width / 8),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: SbtColor.anaRenk),
          ),
          elevation: 5, // Gölge miktarı
          shadowColor: Colors.blue, // Gölge rengi
        ),
        child: Text(label, style: SbtTextStyle.midiumStyle),
      ),
    );
  }
}
