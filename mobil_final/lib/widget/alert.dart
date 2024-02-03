import 'package:flutter/material.dart';
import 'package:yemekhane/sabitler/color.dart';
import 'package:yemekhane/sabitler/text_style.dart';

class SbtAlerWidget extends StatelessWidget {
  final String baslik, icerik;
  const SbtAlerWidget({
    super.key,
    required this.baslik,
    required this.icerik,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: SbtColor.anaRenk,
      title: Text(
        baslik,
        style: SbtTextStyle.textfildBaslik,
      ),
      content: Text(
        icerik,
        style: SbtTextStyle.midiumStyle,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dialog'u kapat
          },
          child: const Text(
            'Kapat',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
