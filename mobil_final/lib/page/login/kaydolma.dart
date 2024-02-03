import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemekhane/page/home/home.dart';
import 'package:yemekhane/page/login/textfild.dart';
import 'package:yemekhane/widget/alert.dart';
import 'package:yemekhane/widget/buton.dart';

class KaydolmaScreen extends StatefulWidget {
  const KaydolmaScreen({super.key});

  @override
  State<KaydolmaScreen> createState() => _KaydolmaScreenState();
}

class _KaydolmaScreenState extends State<KaydolmaScreen> {
  var adController = TextEditingController();
  var mailController = TextEditingController();
  var gitController = TextEditingController();
  var telController = TextEditingController();

  String imagePath = 'assets/image/login.png';

  //Database
  SharedPreferences? prefUser;
  @override
  void initState() {
    super.initState();
    dataBaseInitil();
  }

  Future<void> dataBaseInitil() async {
    prefUser = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: size.width / 3,
                height: size.width / 3,
              ),
              SbtTextfild(
                  controller: adController,
                  label: 'Ad Soyad',
                  icon: const Icon(Icons.person)),
              SbtTextfild(
                  controller: mailController,
                  label: 'Mail',
                  icon: const Icon(Icons.mail)),
              SbtTextfild(
                  controller: gitController,
                  label: 'Github',
                  icon: const Icon(Icons.usb_rounded)),
              SbtTextfild(
                  controller: telController,
                  label: 'Tel',
                  icon: const Icon(Icons.phone)),
              SbtButon(
                label: 'Kaydol',
                press: () async {
                  if (adController.text.isNotEmpty &&
                      mailController.text.isNotEmpty &&
                      gitController.text.isNotEmpty &&
                      telController.text.isNotEmpty) {
                    await prefUser!
                        .setString('name', adController.text.toString());
                    await prefUser!
                        .setString('mail', mailController.text.toString());
                    await prefUser!
                        .setString('git', gitController.text.toString());
                    await prefUser!
                        .setString('tel', telController.text.toString());
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const SbtAlerWidget(
                            baslik: 'Uyarı',
                            icerik:
                                'Lütfen tüm alanların dolu olduğuna emin olduktan sonra tekrar dene.');
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
