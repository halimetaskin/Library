import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemekhane/page/yorumlar/yorum_yap.dart';
import 'package:yemekhane/sabitler/color.dart';
import 'package:yemekhane/sabitler/text_style.dart';

class YorumSayfasi extends StatefulWidget {
  const YorumSayfasi({super.key});

  @override
  State<YorumSayfasi> createState() => _YorumSayfasiState();
}

class _YorumSayfasiState extends State<YorumSayfasi> {
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
        title: Text(
          'Sizden Gelenler',
          style: SbtTextStyle.appbarText,
        ),
      ),
      body: allYorum.isNotEmpty
          ? ListView.builder(
              itemCount: allYorum.length,
              itemBuilder: (context, index) {
                return Card(
                  color: SbtColor.anaRenk,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      allYorum[index],
                      style: SbtTextStyle.textfildBaslikMini,
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('Henüz yorum yapılmadı'),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SbtColor.anaRenk,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const YorumYapSayfasi()),
          );
        },
        child: const Icon(
          Icons.add_comment,
          color: Colors.white,
        ),
      ),
    );
  }
}
