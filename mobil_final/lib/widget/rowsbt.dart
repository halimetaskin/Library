import 'package:flutter/material.dart';

class SbtRow extends StatelessWidget {
  final String name;
  final Icon icon;
  final bool bold;
  const SbtRow(
      {super.key, required this.icon, required this.name, this.bold = false});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Row(
      children: [
        SizedBox(width: size.width * 0.03),
        icon,
        SizedBox(width: size.width * 0.02),
        Text(
          name,
          style: bold
              ? const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)
              : const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}
