import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yemekhane/model/user_model.dart';
import 'package:yemekhane/page/yorumlar/yorum.dart';
import 'package:yemekhane/sabitler/color.dart';
import 'package:yemekhane/sabitler/text_style.dart';
import 'package:yemekhane/services/themedata.dart';
import 'package:yemekhane/services/userlis.dart';
import 'package:yemekhane/widget/alert.dart';
import 'package:yemekhane/widget/rowsbt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Database
  SharedPreferences? prefUser;

  String name = '';
  String mail = '';
  String git = '';
  String tel = '';

  bool masaTutmaDurumu = false;

  List<bool> deskDoluBos = [
    true,
    true,
    true,
    false,
    true,
    false,
    false,
    false,
    true,
    false,
    false,
    false,
    true,
    true
  ];
  bool switcHTheme = false;
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provTheme = Provider.of<SerTehmeData>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const YorumSayfasi()),
                );
              },
              icon: const Icon(Icons.message)),
          iconTheme: IconThemeData(color: SbtColor.anaRenk),
          elevation: 0,
          title: Text(
            'Kütüphanem',
            style: SbtTextStyle.appbarText,
          ),
          actions: [
            Switch(
              focusColor: SbtColor.anaRenk,
              hoverColor: SbtColor.anaRenk,
              activeTrackColor: Colors.blueAccent,
              activeColor: SbtColor.anaRenk,
              inactiveThumbColor: SbtColor.anaRenk,
              value: switcHTheme,
              onChanged: (value) {
                setState(() {
                  switcHTheme = !switcHTheme;
                });
                provTheme.temaDegistir();
              },
            )
          ],
        ),
        body: Center(
          child: GridView.builder(
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return deskDoluBos[index]
                  ? InkWell(
                      //Kişiye tıklandığında arama işlemi
                      //URL launcher
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: SbtColor.anaRenk,
                              title: Text(
                                'Bir işlem seç',
                                style: SbtTextStyle.textfildBaslik,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    urlTelLink(tel);
                                  },
                                  child: Text(
                                    tel,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                //Gitup link
                                TextButton(
                                  onPressed: () {
                                    urlLinkSet(git);
                                  },
                                  child: Text(
                                    git,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width / 2.5,
                          height: size.width / 2.5,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/image/desk.png'), // Resim dosyanızın yolu
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Opacity(
                            opacity: 0.8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: size.height * 0.01),
                                  SbtRow(
                                      icon: const Icon(Icons.phone),
                                      name:
                                          SbtList.baseUserList[index].userName,
                                      bold: true),
                                  SbtRow(
                                    icon: const Icon(Icons.mail),
                                    name: SbtList.baseUserList[index].mail,
                                  ),
                                  SbtRow(
                                    icon: const Icon(Icons.phone),
                                    name: SbtList.baseUserList[index].tel,
                                  ),
                                  SbtRow(
                                    icon: const Icon(Icons.usb_rounded),
                                    name: SbtList.baseUserList[index].git,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  :
                  //Masa boş
                  InkWell(
                      onTap: () {
                        showConfirmationDialog(context, index);
                      },
                      child: Container(
                        width: size.width / 2.5,
                        height: size.width / 2.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/image/desk.png'), // Resim dosyanızın yolu
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Opacity(
                          opacity: 0.8,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [],
                            ),
                          ),
                        ),
                      ),
                    );
            },
          ),
        ));
  }

  getData() {
    dataBaseInitil();

    if (prefUser != null) {
      setState(() {
        name = prefUser!.getString('name').toString();
        mail = prefUser!.getString('mail').toString();
        tel = prefUser!.getString('tel').toString();
        git = prefUser!.getString('git').toString();
      });
    }
  }

  void showConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sayın $name'),
          content: const Text('Derse bu masada başlayacağını onaylıyormusun?'),
          actions: [
            TextButton(
              onPressed: () {
                if (masaTutmaDurumu == false) {
                  setState(() {
                    //Masa tutma durumuna göre bir kişi en fazla biir masa tutabilecek
                    masaTutmaDurumu = true;
                    //Sabit listemizin ilgili indexini ShareP. dan yani veri tabanından gelen user bilgisiyle güncelliyorum
                    SbtList.baseUserList[index] = UsermModel(
                        userName: name, mail: mail, tel: tel, git: git);
                    //Ekranda gözükme durumunu kontrol ettiğim listenin ilgili indexinde güncelleme yapıyorum
                    //Böylelikle masanın durumunu ekranda göstermiş olacağım
                    deskDoluBos[index] = true;
                    Navigator.of(context).pop();
                  });
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Zaten bir masa tuttunuz!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Onayla'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
                // İşlemi reddetme işlemleri buraya eklenebilir
                // Örneğin: reddet();
              },
              child: const Text('Reddet'),
            ),
          ],
        );
      },
    );
  }

  Future<void> urlLinkSet(String git) async {
    var url = 'https://$git';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      launch(url);
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return const SbtAlerWidget(
              baslik: 'Uyarı', icerik: 'Geçersiz bir url girdiniz');
        },
      );
    }
  }

  Future urlTelLink(String tel) async {
    // ignore: deprecated_member_use
    if (await canLaunch('tel:$tel')) {
      // ignore: deprecated_member_use
      launch('tel:$tel');
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return const SbtAlerWidget(
              baslik: 'Uyarı', icerik: 'Geçersiz bir numara girdiniz');
        },
      );
    }
  }
}
