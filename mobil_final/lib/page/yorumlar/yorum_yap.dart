import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemekhane/page/home/home.dart';
import 'package:yemekhane/page/login/textfild.dart';
import 'package:yemekhane/sabitler/color.dart';
import 'package:yemekhane/widget/buton.dart';

class YorumYapSayfasi extends StatefulWidget {
  const YorumYapSayfasi({super.key});

  @override
  State<YorumYapSayfasi> createState() => _YorumYapSayfasiState();
}

class _YorumYapSayfasiState extends State<YorumYapSayfasi> {
  var yorumController = TextEditingController();

  List<String> allYorum = [];

  @override
  void initState() {
    super.initState();
    loadListFromSharedPreferences();
  }

  void loadListFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      allYorum = prefs.getStringList('itemList') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: SbtColor.anaRenk),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SbtTextfild(
              controller: yorumController,
              label: 'Yorum',
              icon: Icon(
                Icons.add_comment_rounded,
                color: SbtColor.anaRenk,
              ),
            ),
            SbtButon(
              label: 'Yorum Yap',
              press: () async {
                if (yorumController.text.isNotEmpty) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  allYorum.add(yorumController.text.toString());
                  prefs.setStringList('itemList', allYorum);
                  yorumController.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } else {}
              },
            )
          ],
        ),
      ),
    );
  }
}
