import 'package:flutter/material.dart';
import 'package:yemekhane/sabitler/text_style.dart';

import '../../sabitler/color.dart';

// ignore: must_be_immutable
class SbtTextfild extends StatelessWidget {
  TextEditingController controller;
  String label;
  Widget icon;
  bool pasword;

  SbtTextfild({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.pasword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
      child: TextField(
        obscureText: pasword == false ? false : true,
        style: SbtTextStyle.textfildBaslik,
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          prefix: icon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SbtColor.anaRenk),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
