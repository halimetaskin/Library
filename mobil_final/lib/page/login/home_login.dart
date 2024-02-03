import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemekhane/page/home/home.dart';
import 'package:yemekhane/page/login/kaydolma.dart';
import 'package:yemekhane/page/login/textfild.dart';
import 'package:yemekhane/sabitler/color.dart';
import 'package:yemekhane/services/themedata.dart';
import 'package:yemekhane/widget/alert.dart';
import 'package:yemekhane/widget/buton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mailController = TextEditingController();
  var sifreController = TextEditingController();

  // ignore: non_constant_identifier_names
  String imagePath = 'assets/image/giris.png';
  String mail = '';

  //DaTA BASE
  SerTehmeData database = SerTehmeData();
  //Database
  SharedPreferences? prefUser;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> dataBaseInitil() async {
    prefUser = await SharedPreferences.getInstance();
  }

  Future<void> initData() async {
    await dataBaseInitil();
    getData();
  }

  getData() {
    dataBaseInitil();

    if (prefUser != null) {
      setState(() {
        mail = prefUser!.getString('name').toString();
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Kütüphane',
                  style: GoogleFonts.dancingScript(
                    textStyle: TextStyle(
                        color: SbtColor.anaRenk,
                        fontSize: size.width / 8,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                image(size),
                mailTextField(),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Giriş
                    // Giriş kontrolü yapılarak sisteme giriş sağlanacak
                    SbtButon(
                      label: 'Giris',
                      press: () {
                        // await provTheme.temaDegistir();
                        if (mail == mailController.text.toString()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const SbtAlerWidget(
                                  baslik: 'Uyarı',
                                  icerik:
                                      'Lütfen sisteme kayıtlı mail ile giriş yapmayı dene');
                            },
                          );
                        }
                      },
                    ),
                    // Kaydol
                    SbtButon(
                      label: 'Kaydol',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const KaydolmaScreen()),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SbtTextfild mailTextField() {
    return SbtTextfild(
      controller: mailController,
      label: 'Mail',
      icon: const Icon(Icons.mail),
    );
  }

  Image image(Size size) {
    return Image.asset(
      imagePath,
      width: size.width / 2,
      height: size.height / 4,
    );
  }
}
